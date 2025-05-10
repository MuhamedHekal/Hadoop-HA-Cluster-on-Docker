#!/bin/bash -l

export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-arm64
export HADOOP_HOME=/home/hadoop/hadoop
export HADOOP_INSTALL=$HADOOP_HOME
export HADOOP_MAPRED_HOME=$HADOOP_HOME
export HADOOP_COMMON_HOME=$HADOOP_HOME
export HADOOP_HDFS_HOME=$HADOOP_HOME
export HADOOP_YARN_HOME=$HADOOP_HOME
export HADOOP_COMMON_LIB_NATIVE_DIR=$HADOOP_HOME/lib/native
export HADOOP_OPTS="-Djava.library.path=$HADOOP_HOME/lib/native"
export ZOOKEEPER_HOME=/home/hadoop/zookeeper
export HIVE_HOME=/home/hadoop/hive
export HIVE_CONF_DIR=$HIVE_HOME/conf
export TEZ_HOME=/home/hadoop/tez
export SQOOP_HOME=/home/hadoop/sqoop
export PATH=$PATH:$HADOOP_HOME/sbin:$HADOOP_HOME/bin:$ZOOKEEPER_HOME/bin:$HIVE_HOME/bin:$TEZ_HOME/bin:$SQOOP_HOME/bin
export TEZ_CONF_DIR=$TEZ_HOME/conf
export TEZ_JARS=$TEZ_HOME/*:$TEZ_HOME/lib/*
export HADOOP_CLASSPATH=$TEZ_CONF_DIR:$TEZ_JARS

# Configuration
ORACLE_CONN="jdbc:oracle:thin:@//oracle_db:1521/FREEPDB1"
USERNAME="airline_op"
PASSWORD="airline"
BASE_DIR="/data/airline"
LOG_DIR="$HOME/sqoop_logs"
mkdir -p "$LOG_DIR"

# Function to perform incremental load
incremental_load() {
    local TABLE_NAME=$1
    local MERGE_KEY=$2
    local CHECK_COLUMN=$3
    
    local TIMESTAMP_FILE="${BASE_DIR}/${TABLE_NAME}/last_load_timestamp"
    local LOG_FILE="${LOG_DIR}/sqoop_${TABLE_NAME}_import.log"
    
    # Initialize logging
    log() {
        echo "[$(date +'%Y-%m-%d %H:%M:%S')] $1" >> "$LOG_FILE"
    }
    
    log "Starting incremental load for table ${TABLE_NAME}"
    
    # Ensure base directory exists
    /home/hadoop/hadoop/bin/hadoop fs -mkdir -p "${BASE_DIR}/${TABLE_NAME}" >> "$LOG_FILE" 2>&1
    
    # Get last load timestamp or default to a very old date
    if hadoop fs -test -e "$TIMESTAMP_FILE"; then
        LAST_VALUE=$(hadoop fs -cat "$TIMESTAMP_FILE")
        log "Loaded LAST_VALUE from timestamp file: $LAST_VALUE"
    else
        # Jan 1, 1970 at midnight for full load if no timestamp file exists
        LAST_VALUE="19700101000000"
        log "No timestamp file found, using default: $LAST_VALUE"
    fi
    
    # Convert LAST_VALUE to Oracle date format for Sqoop
    ORACLE_DATE=$(date -d "${LAST_VALUE:0:4}-${LAST_VALUE:4:2}-${LAST_VALUE:6:2} ${LAST_VALUE:8:2}:${LAST_VALUE:10:2}:${LAST_VALUE:12:2}" +"%Y-%m-%d %H:%M:%S")
    
    # Current load timestamp (now)
    CURRENT_LOAD=$(date +"%Y%m%d%H%M%S")
    TARGET_DIR="${BASE_DIR}/${TABLE_NAME}/${CURRENT_LOAD}"
    
    log "Loading data newer than ${ORACLE_DATE} into ${TARGET_DIR}"
    
    # Execute Sqoop import
    sqoop import \
        --connect "$ORACLE_CONN" \
        --username "$USERNAME" \
        --password "$PASSWORD" \
        --table "$TABLE_NAME" \
        --target-dir "$TARGET_DIR" \
        --incremental lastmodified \
        --check-column "$CHECK_COLUMN" \
        --merge-key "$MERGE_KEY" \
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
        
        # Create success marker
        /home/hadoop/hadoop/bin/hadoop fs -touchz "${TARGET_DIR}/_SUCCESS"
    else
        log "ERROR: Sqoop import failed for ${TABLE_NAME}"
        return 1
    fi
    
    log "Incremental load for ${TABLE_NAME} completed successfully"
    log "========================================================================================================================================================================================================================================================================================================================================================================"
    return 0
}

# Table configuration (table_name merge_key check_column)
TABLE_CONFIG=(
    "AIRCRAFT AIRCRAFT_ID UPDATED_AT"
    "AIRPORT AIRPORT_ID UPDATED_AT"
    "PASSENGER PASSENGER_ID UPDATED_AT"
    "FLIGHT_SCHEDULE SCHEDULE_ID UPDATED_AT"
    "FLIGHT FLIGHT_ID UPDATED_AT"
    "CLASS_SERVICES CLASS_SERVICE_ID UPDATED_AT"
    "PROMOTION PROMOTION_ID UPDATED_AT"
    "BOOKING BOOKING_ID UPDATED_AT"
    "TRIP_STATUS STATUS_ID UPDATED_AT"
    "FLIGHT_STATUS_LOG LOG_ID UPDATED_AT"
    "TICKET TICKET_ID UPDATED_AT"
    "SEAT_ASSIGNMENT ASSIGNMENT_ID UPDATED_AT"
    "FLIGHT_MILEAGE MILEAGE_ID UPDATED_AT"
    "OVERNIGHT_STAY STAY_ID UPDATED_AT"
)

# Main execution
for config in "${TABLE_CONFIG[@]}"; do
    read -r TABLE MERGE_KEY CHECK_COL <<< "$config"
    incremental_load "$TABLE" "$MERGE_KEY" "$CHECK_COL"
    
    if [ $? -ne 0 ]; then
        echo "Error loading table ${TABLE}" >&2
        # Continue with next table even if one fails
    fi
done

echo "All incremental loads completed at $(date)"

for f in sqoop_logs/*.log; do tail -n 1 "$f"; done | grep "ERROR:" # get the last line of each log file and grep for ERROR