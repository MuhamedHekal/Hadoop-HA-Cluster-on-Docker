CREATE DATABASE IF NOT EXISTS AirLine;
USE AirLine;
-- ========================
-- Static Dimension Tables (Non-ACID)
-- ========================

CREATE EXTERNAL TABLE IF NOT EXISTS AirLine.aircraft_dim (
    aircraft_id INT,
    aircraft_name STRING,
    number_of_seats INT,
    aircraft_model STRING,
    manufacture_year INT
)
STORED AS ORC;


CREATE EXTERNAL TABLE IF NOT EXISTS AirLine.airport_dim (
    airport_id INT,
    airport_code STRING,
    airport_name STRING,
    airport_city STRING,
    airport_location STRING
)
STORED AS ORC;


CREATE EXTERNAL TABLE IF NOT EXISTS AirLine.trip_status_dim (
    status_id INT,
    reservation_status STRING,
    cancellation_reason STRING
)
STORED AS ORC;


CREATE EXTERNAL TABLE IF NOT EXISTS AirLine.class_services_dim (
    class_of_services_id INT,
    class_purchased STRING,
    class_flown STRING,
    class_change_indicator STRING
)
STORED AS ORC;


CREATE EXTERNAL TABLE IF NOT EXISTS AirLine.promotion_dim (
    promotion_id INT,
    valid_from DATE,
    valid_to DATE,
    maximum_fare_discount DECIMAL(10,2),
    promotion_percentage DECIMAL(5,2),
    category STRING
)
STORED AS ORC;


CREATE EXTERNAL TABLE IF NOT EXISTS AirLine.time_dim (
    time_id TIMESTAMP,
    hour INT,
    minute INT,
    time_string STRING,
    hour_description STRING
)
STORED AS ORC;

CREATE EXTERNAL TABLE IF NOT EXISTS AirLine.date_dim (
    date_id DATE,
    year INT,
    quarter INT,
    month INT,
    day_of_week INT,
    day_of_month INT,
    day_of_year INT,
    week_of_year INT,
    is_holiday INT
)
STORED AS ORC;

-- ========================
-- ACID Dimension and Fact Tables with Partitioning
-- ========================

-- customer_dim (needs ACID and partitioned by is_current)
CREATE TABLE IF NOT EXISTS  AirLine.customer_dim (
    passenger_id INT,
    passenger_name STRING,
    passenger_dateOfBirth DATE,
    passenger_gender STRING,
    passenger_address STRING,
    passenger_phone STRING,
    passenger_points INT,
    passenger_status STRING,
    start_date DATE,
    end_date DATE,
    is_current STRING
)
PARTITIONED BY (start_year INT) -- filtering in is current more frequently 
CLUSTERED BY (passenger_id) INTO 4 BUCKETS -- 4 buckets per partition
STORED AS ORC
TBLPROPERTIES (
                'transactional'='true',
                'orc.compress'='SNAPPY'
            );


-- flight_dim (needs ACID and partitioned by year and quarter)
CREATE TABLE IF NOT EXISTS AirLine.flight_dim (
    flight_id INT,
    origin_airport_id INT,
    destination_airport_id INT,
    origin_airport_code STRING, --added for denormalization and skip joins
    destination_airport_code STRING, --added for denormalization
    aircraft_model STRING, --added for denormalization
    aircraft_id INT,
    origin_date DATE,
    origin_time TIMESTAMP,
    arrival_date DATE,
    arrival_time TIMESTAMP,
    segment_miles DECIMAL(10,2),
    miles_earned DECIMAL(10,2)
)
PARTITIONED BY (year INT, quarter INT)  -- from origin_date
CLUSTERED BY (flight_id) INTO 4 BUCKETS -- 4 buckets for partition
STORED AS ORC
TBLPROPERTIES (
                'transactional'='true',
                'orc.compress'='SNAPPY'
                );

CREATE TABLE IF NOT EXISTS AirLine.SegmentActivityFact (
    passenger_id INT,
    class_services_id INT,
    promotion_id INT,
    flight_id INT,
    status_id INT,
    -- aircraft_id INT, -- removed they are in flight_dim
    -- airport_id INT,  -- they are in flight_dim
    ticket_number STRING,
    overnight_stay INT,
    revenue_amount DECIMAL(10,2),
    cancellation_fees DECIMAL(10,2),
    refund_amount DECIMAL(10,2),
    date_id DATE,
    time_id TIMESTAMP,
    passenger_status STRING, -- frequently aggregated column embedded for performance
    passenger_points INT, -- frequently aggregated column embedded for performance
)
PARTITIONED BY (year INT, month INT)
CLUSTERED BY (flight_id) INTO 8 BUCKETS -- joined with flight_dim
STORED AS ORC
TBLPROPERTIES (
                'transactional'='true',
                'orc.compress'='SNAPPY'
            );
