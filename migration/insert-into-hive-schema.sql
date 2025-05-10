-- Set Hive properties for transactional tables
SET hive.support.concurrency=true;
SET hive.enforce.bucketing=true;
SET hive.exec.dynamic.partition.mode=nonstrict;
SET hive.txn.manager=org.apache.hadoop.hive.ql.lockmgr.DbTxnManager;
SET hive.compactor.initiator.on=true;
SET hive.compactor.worker.threads=1;

-- Load static dimensions (non-ACID)
INSERT OVERWRITE TABLE AirLine.aircraft_dim
SELECT * FROM aircraft_dim_staging;

INSERT OVERWRITE TABLE AirLine.airport_dim
SELECT * FROM airport_dim_staging;

INSERT OVERWRITE TABLE AirLine.trip_status_dim
SELECT * FROM trip_status_dim_staging;

INSERT OVERWRITE TABLE AirLine.class_services_dim
SELECT * FROM class_services_dim_staging;

INSERT OVERWRITE TABLE AirLine.promotion_dim
SELECT 
    promotion_id,
    to_date(valid_from) as valid_from,
    to_date(valid_to) as valid_to,
    maximum_fare_discount,
    promotion_percentage,
    category
FROM promotion_dim_staging;


INSERT INTO TABLE AirLine.time_dim
SELECT 
    CAST(time_id AS TIMESTAMP) AS time_id,
    hour,
    minute,
    CONCAT(LPAD(hour, 2, '0'), ':', LPAD(minute, 2, '0')) AS time_string,
    hour_description
FROM time_dim_staging;


INSERT OVERWRITE TABLE AirLine.date_dim
SELECT 
    to_date(date_id) as date_id,
    year,
    quarter,
    month,
    day_of_week,
    day_of_month,
    day_of_year,
    week_of_year,
    is_holiday
FROM date_dim_staging;

-- Load ACID dimension tables with partitioning
INSERT OVERWRITE TABLE AirLine.customer_dim PARTITION(start_year)
SELECT 
    passenger_id,
    passenger_name,
    to_date(passenger_dateOfBirth) as passenger_dateOfBirth,
    passenger_gender,
    passenger_city,
    passenger_phone,
    passenger_points,
    passenger_status,
    to_date(start_date) as start_date,
    to_date(end_date) as end_date,
    is_current,
    year(to_date(start_date)) as start_year
    
FROM customer_dim_staging;


-- For flight_dim, we need to join with airport_dim and aircraft_dim to get denormalized columns
INSERT OVERWRITE TABLE AirLine.flight_dim PARTITION(year, quarter)
SELECT 
    f.flight_id,
    f.origin_airport_id,
    f.destination_airport_id,
    orig.airport_code AS origin_airport_code,
    dest.airport_code AS destination_airport_code,
    a.aircraft_model,
    f.aircraft_id,
    TO_DATE(f.origin_date) AS origin_date,
    CAST(ts1.time_id AS TIMESTAMP) AS origin_time,
    TO_DATE(f.arrival_date) AS arrival_date,
    CAST(ts2.time_id AS TIMESTAMP) AS arrival_time,
    CAST(f.segment_miles AS DECIMAL(10,2)) AS segment_miles,
    CAST(f.miles_earned AS DECIMAL(10,2)) AS miles_earned,
    YEAR(TO_DATE(f.origin_date)) AS year,
    QUARTER(TO_DATE(f.origin_date)) AS quarter
FROM flight_dim_staging f
JOIN airport_dim orig ON f.origin_airport_id = orig.airport_id
JOIN airport_dim dest ON f.destination_airport_id = dest.airport_id
JOIN aircraft_dim a ON f.aircraft_id = a.aircraft_id
JOIN time_dim_staging ts1 ON f.origin_time = ts1.time_id
JOIN time_dim_staging ts2 ON f.arrival_time = ts2.time_id;

-- For SegmentActivityFact, we need to join with customer_dim to get denormalized columns
INSERT OVERWRITE TABLE AirLine.SegmentActivityFact PARTITION(year, month)
SELECT 
    s.passenger_id,
    s.class_services_id,
    s.promotion_id,
    s.flight_id,
    s.status_id,
    s.ticket_number,
    s.overnight_stay,
    s.revenue_amount,
    s.cancellation_fees,
    s.refund_amount,
    to_date(d.date_id) as date_id,
    t.time_id,
    c.passenger_status,
    c.passenger_points,
    year(to_date(d.date_id)) as year,
    month(to_date(d.date_id)) as month
FROM SegmentActivityFact_staging s
JOIN date_dim_staging d ON s.date_id = d.date_id
JOIN time_dim_staging t ON s.time_id = t.time_id
JOIN customer_dim_staging c ON s.passenger_id = c.passenger_id;