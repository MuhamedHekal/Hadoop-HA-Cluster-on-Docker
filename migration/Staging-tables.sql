USE AirLine;

-- Create staging tables for each dimension (temporary text tables)
CREATE EXTERNAL TABLE IF NOT EXISTS aircraft_dim_staging (
    aircraft_id INT,
    aircraft_name STRING,
    number_of_seats INT,
    aircraft_model STRING,
    manufacture_year INT
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
STORED AS TEXTFILE
LOCATION '/airline-staging-area/aircraft_dim';

CREATE EXTERNAL TABLE IF NOT EXISTS airport_dim_staging (
    airport_id INT,
    airport_code STRING,
    airport_name STRING,
    airport_city STRING,
    airport_location STRING
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
STORED AS TEXTFILE
LOCATION '/airline-staging-area/airport_dim';

CREATE EXTERNAL TABLE IF NOT EXISTS trip_status_dim_staging (
    status_id INT,
    reservation_status STRING,
    cancellation_reason STRING
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
STORED AS TEXTFILE
LOCATION '/airline-staging-area/trip_status_dim';

CREATE EXTERNAL TABLE IF NOT EXISTS class_services_dim_staging (
    class_of_services_id INT,
    class_purchased STRING,
    class_flown STRING,
    class_change_indicator STRING
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
STORED AS TEXTFILE
LOCATION '/airline-staging-area/class_services_dim';

CREATE EXTERNAL TABLE IF NOT EXISTS promotion_dim_staging (
    promotion_id INT,
    valid_from STRING, -- Will convert to DATE later
    valid_to STRING, -- Will convert to DATE later
    maximum_fare_discount DECIMAL(10,2),
    promotion_percentage DECIMAL(5,2),
    category STRING
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
STORED AS TEXTFILE
LOCATION '/airline-staging-area/promotion_dim';

CREATE EXTERNAL TABLE IF NOT EXISTS time_dim_staging (
    time_id STRING,
    hour INT,
    minute INT,
    hour_description STRING
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
STORED AS TEXTFILE
LOCATION '/airline-staging-area/time_dim';

CREATE EXTERNAL TABLE IF NOT EXISTS date_dim_staging (
    date_id STRING, -- Will convert to DATE later
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
STORED AS TEXTFILE
LOCATION '/airline-staging-area/date_dim';

CREATE EXTERNAL TABLE IF NOT EXISTS customer_dim_staging (
    sk_passenger_id INT,
    passenger_id INT,
    passenger_name STRING,
    passenger_dateOfBirth STRING, -- Will convert to DATE later
    passenger_gender STRING,
    passenger_city STRING,
    passenger_country STRING,
    passenger_phone STRING,
    passenger_points INT,
    passenger_status STRING,
    start_date STRING, -- Will convert to DATE later
    end_date STRING, -- Will convert to DATE later
    is_current STRING
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
STORED AS TEXTFILE
LOCATION '/airline-staging-area/customer_dim';

CREATE EXTERNAL TABLE IF NOT EXISTS flight_dim_staging (
    flight_id INT,
    origin_airport_id INT,
    destination_airport_id INT,
    origin_date STRING, -- Will convert to DATE later
    origin_time STRING, -- time_id reference
    arrival_date STRING, -- Will convert to DATE later
    arrival_time STRING, -- time_id reference
    aircraft_id INT,
    segment_miles STRING, -- Will convert to DECIMAL later
    miles_earned STRING -- Will convert to DECIMAL later
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
STORED AS TEXTFILE
LOCATION '/airline-staging-area/flight_dim';

CREATE EXTERNAL TABLE IF NOT EXISTS SegmentActivityFact_staging (
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
    date_id STRING, -- date_dim reference
    time_id STRING -- time_dim reference
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
STORED AS TEXTFILE
LOCATION '/airline-staging-area/SegmentActivityFact';