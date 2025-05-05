#!/bin/bash

# Configuration
ORACLE_CONN="jdbc:oracle:thin:@//oracle_db:1521/FREEPDB1"
USERNAME="airline_op"
PASSWORD="airline"
BASE_DIR="/data/airline/aircraft"
TIMESTAMP_FILE="${BASE_DIR}/last_load_timestamp"
LOG_DIR="$HOME/sqoop_logs"
LOG_FILE="${LOG_DIR}/sqoop_aircraft_import.log"

# Create log directory if it doesn't exist
mkdir -p "$LOG_DIR"

# Initialize logging
log() {
  echo "[$(date +'%d-%m-%Y %H:%M:%S')] $1" >> "$LOG_FILE"
}

# Ensure base directory exists
hadoop fs -mkdir -p "$BASE_DIR" >> "$LOG_FILE" 2>&1

# Get last load timestamp or default to yesterday midnight
if hadoop fs -test -e "$TIMESTAMP_FILE"; then
  LAST_VALUE=$(hadoop fs -cat "$TIMESTAMP_FILE")
  log "Loaded LAST_VALUE from timestamp file: $LAST_VALUE"
else
  LAST_VALUE=$(date -d "yesterday 00:00:00" +"%d%m%Y%H%M%S")
  log "No timestamp file found, using default: $LAST_VALUE"
fi

# Convert LAST_VALUE to Oracle date format for Sqoop
ORACLE_DATE=$(date -d "${LAST_VALUE:0:2}/${LAST_VALUE:2:2}/${LAST_VALUE:4:4} ${LAST_VALUE:8:2}:${LAST_VALUE:10:2}:${LAST_VALUE:12:2}" +"%Y-%m-%d %H:%M:%S")

# Current load timestamp (now)
CURRENT_LOAD=$(date +"%d%m%Y%H%M%S")
TARGET_DIR="${BASE_DIR}/${CURRENT_LOAD}"

log "Starting incremental load to ${TARGET_DIR} with data newer than ${ORACLE_DATE}"

# Execute Sqoop import
sqoop import \
  --connect "$ORACLE_CONN" \
  --username "$USERNAME" \
  --password "$PASSWORD" \
  --table AIRCRAFT \
  --target-dir "$TARGET_DIR" \
  --incremental lastmodified \
  --check-column UPDATED_AT \
  --merge-key AIRCRAFT_ID \
  --last-value "$ORACLE_DATE" \
  --fields-terminated-by ',' \
  --null-string '\\N' \
  --null-non-string '\\N' \
  >> "$LOG_FILE" 2>&1

# Handle Sqoop result
if [ $? -eq 0 ]; then
  # Update timestamp file with current load time
  echo "$CURRENT_LOAD" | hadoop fs -put -f - "$TIMESTAMP_FILE"
  log "Successfully loaded data to ${TARGET_DIR}"
  log "Updated timestamp file with ${CURRENT_LOAD}"
  
  # Create success marker
  hadoop fs -touchz "${TARGET_DIR}/_SUCCESS"
else
  log "ERROR: Sqoop import failed for ${TARGET_DIR}"
  exit 1
fi

log "Incremental load completed successfully"