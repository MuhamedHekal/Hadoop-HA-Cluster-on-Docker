-- Create a temporary table to store verification results
CREATE TABLE IF NOT EXISTS temp_verification_results (
    table_name STRING,
    staging_count BIGINT,
    final_count BIGINT
);

-- Insert verification results for each table
INSERT INTO TABLE temp_verification_results
SELECT 'aircraft_dim', 
       (SELECT COUNT(*) FROM aircraft_dim_staging), 
       (SELECT COUNT(*) FROM aircraft_dim);

INSERT INTO TABLE temp_verification_results
SELECT 'airport_dim', 
       (SELECT COUNT(*) FROM airport_dim_staging), 
       (SELECT COUNT(*) FROM airport_dim);

INSERT INTO TABLE temp_verification_results
SELECT 'trip_status_dim', 
       (SELECT COUNT(*) FROM trip_status_dim_staging), 
       (SELECT COUNT(*) FROM trip_status_dim);

INSERT INTO TABLE temp_verification_results
SELECT 'class_services_dim', 
       (SELECT COUNT(*) FROM class_services_dim_staging), 
       (SELECT COUNT(*) FROM class_services_dim);

INSERT INTO TABLE temp_verification_results
SELECT 'promotion_dim', 
       (SELECT COUNT(*) FROM promotion_dim_staging), 
       (SELECT COUNT(*) FROM promotion_dim);

INSERT INTO TABLE temp_verification_results
SELECT 'time_dim', 
       (SELECT COUNT(*) FROM time_dim_staging), 
       (SELECT COUNT(*) FROM time_dim);

INSERT INTO TABLE temp_verification_results
SELECT 'date_dim', 
       (SELECT COUNT(*) FROM date_dim_staging), 
       (SELECT COUNT(*) FROM date_dim);

INSERT INTO TABLE temp_verification_results
SELECT 'customer_dim', 
       (SELECT COUNT(*) FROM customer_dim_staging), 
       (SELECT COUNT(*) FROM customer_dim);

INSERT INTO TABLE temp_verification_results
SELECT 'flight_dim', 
       (SELECT COUNT(*) FROM flight_dim_staging), 
       (SELECT COUNT(*) FROM flight_dim);

INSERT INTO TABLE temp_verification_results
SELECT 'SegmentActivityFact', 
       (SELECT COUNT(*) FROM SegmentActivityFact_staging), 
       (SELECT COUNT(*) FROM SegmentActivityFact);

-- Display all results
SELECT * FROM temp_verification_results;

-- Clean up
DROP TABLE temp_verification_results;