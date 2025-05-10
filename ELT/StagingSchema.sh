#!/bin/bash

# Create the database if it doesn't exist
hive -e " DROP DATABASE IF EXISTS tmp_db cascade; CREATE DATABASE tmp_db;"

# Function to create external table
create_external_table() {
    local table_name=$1
    local hive_table_name="tmp_${table_name}"
    local hdfs_path="/data/airline/${table_name}"
    
    # Get last load timestamp from HDFS
    last_load_timestamp=$(hdfs dfs -cat ${hdfs_path}/last_load_timestamp)
    echo "Creating external table ${hive_table_name} from ${hdfs_path}/${last_load_timestamp}"
    
    # Create the appropriate external table based on table name
    case $table_name in
        "AIRCRAFT")
            hive -e "
            USE tmp_db;
            CREATE EXTERNAL TABLE IF NOT EXISTS ${hive_table_name}(
                aircraft_id INT,
                model STRING,
                name STRING,
                manufacturer STRING,
                manufacture_date DATE,
                total_seats INT,
                status STRING,
                created_at TIMESTAMP,
                updated_at TIMESTAMP
            )
            ROW FORMAT DELIMITED
            FIELDS TERMINATED BY ','
            LOCATION '${hdfs_path}/${last_load_timestamp}';
            "
            ;;
            
        "AIRPORT")
            hive -e "
            USE tmp_db;
            CREATE EXTERNAL TABLE IF NOT EXISTS ${hive_table_name}(
                airport_id INT,
                iata_code STRING,
                airport_name STRING,
                city STRING,
                country STRING,
                latitude DOUBLE,
                longitude DOUBLE,
                timezone STRING,
                created_at TIMESTAMP,
                updated_at TIMESTAMP
            )
            ROW FORMAT DELIMITED
            FIELDS TERMINATED BY ','
            LOCATION '${hdfs_path}/${last_load_timestamp}';
            "
            ;;
            
        "PASSENGER")
            hive -e "
            USE tmp_db;
            CREATE EXTERNAL TABLE IF NOT EXISTS ${hive_table_name}(
                passenger_id INT,
                first_name STRING,
                last_name STRING,
                date_of_birth DATE,
                gender STRING,
                phone STRING,
                address STRING,
                city STRING,
                country STRING,
                passport_number STRING,
                passport_expiry DATE,
                frequent_flyer_points INT,
                membership_tier STRING,
                registration_date DATE,
                created_at TIMESTAMP,
                updated_at TIMESTAMP
            )
            ROW FORMAT DELIMITED
            FIELDS TERMINATED BY ','
            LOCATION '${hdfs_path}/${last_load_timestamp}';
            "
            ;;
            
        "FLIGHT_SCHEDULE")
            hive -e "
            USE tmp_db;
            CREATE EXTERNAL TABLE IF NOT EXISTS ${hive_table_name}(
                schedule_id INT,
                flight_number STRING,
                origin_airport_id INT,
                destination_airport_id INT,
                departure_time_local TIMESTAMP,
                arrival_time_local TIMESTAMP,
                duration_minutes INT,
                operating_days STRING,
                effective_from DATE,
                effective_to DATE,
                aircraft_type_id INT,
                created_at TIMESTAMP,
                updated_at TIMESTAMP
            )
            ROW FORMAT DELIMITED
            FIELDS TERMINATED BY ','
            LOCATION '${hdfs_path}/${last_load_timestamp}';
            "
            ;;
            
        "FLIGHT")
            hive -e "
            USE tmp_db;
            CREATE EXTERNAL TABLE IF NOT EXISTS ${hive_table_name}(
                flight_id INT,
                schedule_id INT,
                actual_departure TIMESTAMP,
                actual_arrival TIMESTAMP,
                aircraft_id INT,
                departure_gate STRING,
                arrival_gate STRING,
                status STRING,
                first_officer_id INT,
                flight_attendant_lead_id INT,
                created_at TIMESTAMP,
                updated_at TIMESTAMP
            )
            ROW FORMAT DELIMITED
            FIELDS TERMINATED BY ','
            LOCATION '${hdfs_path}/${last_load_timestamp}';
            "
            ;;
            
        "CLASS_SERVICES")
            hive -e "
            USE tmp_db;
            CREATE EXTERNAL TABLE IF NOT EXISTS ${hive_table_name}(
                class_service_id INT,
                class_purchased STRING,
                class_flown STRING,
                class_change_indicator STRING,
                meal_options STRING,
                baggage_allowance STRING,
                created_at TIMESTAMP,
                updated_at TIMESTAMP
            )
            ROW FORMAT DELIMITED
            FIELDS TERMINATED BY ','
            LOCATION '${hdfs_path}/${last_load_timestamp}';
            "
            ;;
            
        "PROMOTION")
            hive -e "
            USE tmp_db;
            CREATE EXTERNAL TABLE IF NOT EXISTS ${hive_table_name}(
                promotion_id INT,
                promotion_code STRING,
                description STRING,
                discount_percentage STRING,
                max_discount_amount STRING,
                start_date DATE,
                end_date DATE,
                category STRING,
                created_at TIMESTAMP,
                updated_at TIMESTAMP
            )
            ROW FORMAT DELIMITED
            FIELDS TERMINATED BY ','
            LOCATION '${hdfs_path}/${last_load_timestamp}';
            "
            ;;
            
        "BOOKING")
            hive -e "
            USE tmp_db;
            CREATE EXTERNAL TABLE IF NOT EXISTS ${hive_table_name}(
                booking_id INT,
                passenger_id INT,
                booking_date TIMESTAMP,
                total_amount DECIMAL(10,2),
                payment_status STRING,
                payment_method STRING,
                promotion_id INT,
                created_at TIMESTAMP,
                updated_at TIMESTAMP
            )
            ROW FORMAT DELIMITED
            FIELDS TERMINATED BY ','
            LOCATION '${hdfs_path}/${last_load_timestamp}';
            "
            ;;
            
        "TRIP_STATUS")
            hive -e "
            USE tmp_db;
            CREATE EXTERNAL TABLE IF NOT EXISTS ${hive_table_name}(
                status_id INT,
                reservation_status STRING,
                cancellation_reason STRING,
                is_active STRING,
                created_at TIMESTAMP,
                updated_at TIMESTAMP
            )
            ROW FORMAT DELIMITED
            FIELDS TERMINATED BY ','
            LOCATION '${hdfs_path}/${last_load_timestamp}';
            "
            ;;
            
        "FLIGHT_STATUS_LOG")
            hive -e "
            USE tmp_db;
            CREATE EXTERNAL TABLE IF NOT EXISTS ${hive_table_name}(
                log_id INT,
                flight_id INT,
                status_id INT,
                status_time TIMESTAMP,
                remarks STRING,
                created_at TIMESTAMP,
                updated_at TIMESTAMP
            )
            ROW FORMAT DELIMITED
            FIELDS TERMINATED BY ','
            LOCATION '${hdfs_path}/${last_load_timestamp}';
            "
            ;;
            
        "TICKET")
            hive -e "
            USE tmp_db;
            CREATE EXTERNAL TABLE IF NOT EXISTS ${hive_table_name}(
                ticket_id INT,
                ticket_number STRING,
                booking_id INT,
                flight_id INT,
                passenger_id INT,
                seat_number STRING,
                class_service_id INT,
                fare_amount DECIMAL(10,2),
                taxes_and_fees DECIMAL(10,2),
                status_id INT,
                cancellation_date TIMESTAMP,
                cancellation_reason STRING,
                refund_amount DECIMAL(10,2),
                miles_earned DECIMAL(10,2),
                created_at TIMESTAMP,
                updated_at TIMESTAMP
            )
            ROW FORMAT DELIMITED
            FIELDS TERMINATED BY ','
            LOCATION '${hdfs_path}/${last_load_timestamp}';
            "
            ;;
            
        "SEAT_ASSIGNMENT")
            hive -e "
            USE tmp_db;
            CREATE EXTERNAL TABLE IF NOT EXISTS ${hive_table_name}(
                assignment_id INT,
                ticket_id INT,
                seat_number STRING,
                assignment_date TIMESTAMP,
                created_at TIMESTAMP,
                updated_at TIMESTAMP
            )
            ROW FORMAT DELIMITED
            FIELDS TERMINATED BY ','
            LOCATION '${hdfs_path}/${last_load_timestamp}';
            "
            ;;
            
        "FLIGHT_MILEAGE")
            hive -e "
            USE tmp_db;
            CREATE EXTERNAL TABLE IF NOT EXISTS ${hive_table_name}(
                mileage_id INT,
                origin_airport_id INT,
                destination_airport_id INT,
                distance_miles DECIMAL(10,2),
                effective_date DATE,
                created_at TIMESTAMP,
                updated_at TIMESTAMP
            )
            ROW FORMAT DELIMITED
            FIELDS TERMINATED BY ','
            LOCATION '${hdfs_path}/${last_load_timestamp}';
            "
            ;;
            
        "OVERNIGHT_STAY")
            hive -e "
            USE tmp_db;
            CREATE EXTERNAL TABLE IF NOT EXISTS ${hive_table_name}(
                stay_id INT,
                ticket_id INT,
                stay_date DATE,
                hotel_name STRING,
                city STRING,
                created_at TIMESTAMP,
                updated_at TIMESTAMP
            )
            ROW FORMAT DELIMITED
            FIELDS TERMINATED BY ','
            LOCATION '${hdfs_path}/${last_load_timestamp}';
            "
            ;;
            
        *)
            echo "Unknown table: ${table_name}"
            ;;
    esac
}

# List of tables to process
tables=(
    "AIRCRAFT"
    "AIRPORT"
    "PASSENGER"
    "FLIGHT_SCHEDULE"
    "FLIGHT"
    "CLASS_SERVICES"
    "PROMOTION"
    "BOOKING"
    "TRIP_STATUS"
    "FLIGHT_STATUS_LOG"
    "TICKET"
    "SEAT_ASSIGNMENT"
    "FLIGHT_MILEAGE"
    "OVERNIGHT_STAY"
)

# Create external tables for each table
for table in "${tables[@]}"; do
    create_external_table "$table"
done

echo "All external tables created successfully in tmp_db database."