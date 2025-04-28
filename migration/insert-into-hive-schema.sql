
-- Insert into the aircraft dimension table in the airline database
INSERT OVERWRITE TABLE airline.aircraft_dim
SELECT * FROM tmp_db.tmp_aircraft_dim_table;

-- Insert into the airport dimension table in the airline database
INSERT OVERWRITE TABLE airline.airport_dim
SELECT * FROM tmp_db.tmp_airport_dim_table;

-- Insert into the class services dimension table in the airline database
INSERT OVERWRITE TABLE airline.class_services_dim
SELECT * FROM tmp_db.tmp_class_services_dim_table;

-- Insert into the trip status dimension table in the airline database
INSERT OVERWRITE TABLE airline.trip_status_dim
SELECT * FROM tmp_db.tmp_trip_status_dim_table;

-- Insert into the promotion dimension table in the airline database
INSERT OVERWRITE TABLE airline.promotion_dim
SELECT * FROM tmp_db.tmp_promotion_dim_table;

-- Insert into the time dimension table in the airline database
INSERT OVERWRITE TABLE airline.time_dim
SELECT * FROM tmp_db.tmp_time_dim_table;

-- Insert into the date dimension table in the airline database
INSERT OVERWRITE TABLE airline.date_dim
SELECT * FROM tmp_db.tmp_date_dim_table;

-- Insert into the customer_dim dimension table in the airline database
INSERT INTO TABLE airline.customer_dim
PARTITION (start_year, start_month)
SELECT 
    passenger_id,
    passenger_name,
    passenger_dateOfBirth,
    passenger_gender,
    passenger_address,
    passenger_phone,
    passenger_points,
    passenger_status,
    start_date,
    end_date,
    is_current,
    YEAR(start_date) AS start_year,
    MONTH(start_date) AS start_month
FROM tmp_db.tmp_customer_dim_table;


-- Insert data from tmp_flight_dim_table into the flight_dim table
INSERT INTO TABLE airline.flight_dim PARTITION (year, quarter)
SELECT 
    f.flight_id,
    f.origin_airport_id,
    f.destination_airport_id,
    orig.airport_code AS origin_airport_code,  -- From airport_dim
    dest.airport_code AS destination_airport_code,  -- From airport_dim
    a.aircraft_model,  -- From aircraft_dim
    f.aircraft_id,
    f.origin_date,
    f.origin_time,
    f.arrival_date,
    f.arrival_time,
    CAST(f.segment_miles AS DECIMAL(10,2)) AS segment_miles,  -- Explicit cast
    CAST(f.miles_earned AS DECIMAL(10,2)) AS miles_earned,
    YEAR(f.origin_date) AS year,  -- Partition column
    QUARTER(f.origin_date) AS quarter  -- Partition column
FROM 
    tmp_db.tmp_flight_dim_table f
LEFT JOIN 
    tmp_db.tmp_airport_dim_table orig ON f.origin_airport_id = orig.airport_id
LEFT JOIN 
    tmp_db.tmp_airport_dim_table dest ON f.destination_airport_id = dest.airport_id
LEFT JOIN 
    tmp_db.tmp_aircraft_dim_table a ON f.aircraft_id = a.aircraft_id;



-- Insert data into the target table
INSERT INTO TABLE airline.SegmentActivityFact PARTITION(year, month)
SELECT 
    saf.passenger_id,
    saf.class_services_id,
    saf.promotion_id,
    saf.flight_id,
    saf.status_id,
    saf.ticket_number,
    saf.overnight_stay,
    saf.revenue_amount,
    saf.cancellation_fees,
    saf.refund_amount,
    saf.date_id,
    saf.time_id,
    cd.passenger_status,
    cd.passenger_points,
    YEAR(saf.date_id) AS year,
    MONTH(saf.date_id) AS month
FROM 
    tmp_db.tmp_segment_activity_fact_table saf
JOIN 
    tmp_db.tmp_customer_dim_table cd ON saf.passenger_id = cd.SK_PASSENGER_ID;