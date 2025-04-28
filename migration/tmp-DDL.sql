create DATABASE IF NOT EXISTS tmp_db;
use tmp_db;
-- tmp_aircraft_dim_table
CREATE EXTERNAL TABLE IF NOT EXISTS tmp_aircraft_dim_table (
    aircraft_id INT,
    aircraft_name STRING,
    number_of_seats INT,
    aircraft_model STRING,
    manufacture_year INT
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
LOCATION '/tmp/aircraft_dim';

-- tmp_airport_dim_table
CREATE EXTERNAL TABLE IF NOT EXISTS tmp_airport_dim_table (
    airport_id INT,
    airport_code STRING,
    airport_name STRING,
    airport_city STRING,
    airport_location STRING
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
LOCATION '/tmp/airport_dim';

-- tmp_class_services_dim_table
CREATE EXTERNAL TABLE IF NOT EXISTS tmp_class_services_dim_table (
    class_of_services_id INT,
    class_purchased STRING,
    class_flown STRING,
    class_change_indicator STRING
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
LOCATION '/tmp/class_services_dim';

-- tmp_customer_dim_table
CREATE EXTERNAL TABLE IF NOT EXISTS tmp_customer_dim_table (
    sk_passenger_id INT,
    passenger_id INT,
    passenger_name STRING,
    passenger_dateOfBirth DATE,
    passenger_gender STRING,
    passenger_address STRING,
    passenger_country STRING,
    passenger_phone STRING,
    passenger_points INT,
    passenger_status STRING,
    start_date DATE,
    end_date DATE,
    is_current STRING
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
LOCATION '/tmp/customer_dim';

-- tmp_date_dim_table
CREATE EXTERNAL TABLE IF NOT EXISTS tmp_date_dim_table (
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
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
LOCATION '/tmp/date_dim';

-- tmp_flight_dim_table
CREATE EXTERNAL TABLE IF NOT EXISTS tmp_flight_dim_table (
    flight_id INT,
    origin_airport_id INT,
    destination_airport_id INT,
    origin_date DATE,
    origin_time TIMESTAMP,
    arrival_date DATE,
    arrival_time TIMESTAMP,
    aircraft_id INT,
    segment_miles STRING,
    miles_earned STRING
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
LOCATION '/tmp/flight_dim';

-- tmp_promotion_dim_table
CREATE EXTERNAL TABLE IF NOT EXISTS tmp_promotion_dim_table (
    promotion_id INT,
    valid_from DATE,
    valid_to DATE,
    maximum_fare_discount DECIMAL(10,2),
    promotion_percentage DECIMAL(5,2),
    category STRING
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
LOCATION '/tmp/promotion_dim';

-- tmp_time_dim_table
CREATE EXTERNAL TABLE IF NOT EXISTS tmp_time_dim_table (
    time_id TIMESTAMP,
    hour INT,
    minute INT,
    hour_description STRING
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
LOCATION '/tmp/time_dim';

-- tmp_trip_status_dim_table
CREATE EXTERNAL TABLE IF NOT EXISTS tmp_trip_status_dim_table (
    status_id INT,
    reservation_status STRING,
    cancellation_reason STRING
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
LOCATION '/tmp/trip_status_dim';

-- tmp_segment_activity_fact_table
CREATE EXTERNAL TABLE IF NOT EXISTS tmp_segment_activity_fact_table (
    passenger_id INT,
    class_services_id INT,
    promotion_id INT,
    flight_id INT,
    status_id INT,
    ticket_number STRING,
    overnight_stay INT,
    revenue_amount DECIMAL(10,2),
    cancellation_fees DECIMAL(10,2),
    refund_amount DECIMAL(10,2),
    date_id DATE,
    time_id TIMESTAMP
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
LOCATION '/tmp/SegmentActivityFact';