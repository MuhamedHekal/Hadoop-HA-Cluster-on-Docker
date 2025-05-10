-- Incremental Load for aircraft_dim table
INSERT INTO airline.aircraft_dim
SELECT source.aircraft_id, source.name as aircraft_name, source.total_seats as number_of_seats, source.model as aircraft_model, year(source.manufacture_date) as manufacture_year
FROM tmp_db.tmp_aircraft source
LEFT JOIN airline.aircraft_dim target ON source.aircraft_id = target.aircraft_id
WHERE target.aircraft_id IS NULL;  


-- Incremental Load for airport table
INSERT INTO airline.airport_dim
SELECT source.airport_id, source.iata_code as airport_code, source.airport_name, source.city as airport_city, source.latitude || ',' || source.longitude  as airport_location
FROM tmp_db.tmp_airport source
LEFT JOIN airline.airport_dim target ON source.airport_id = target.airport_id
WHERE target.airport_id IS NULL;

-- Incremental Load for trip_status table
INSERT INTO airline.trip_status_dim
SELECT source.status_id, source.reservation_status, source.cancellation_reason
FROM tmp_db.tmp_trip_status source
LEFT JOIN airline.trip_status_dim target ON source.status_id = target.status_id
WHERE target.status_id IS NULL;

-- Incremental Load for class_services_dim table
INSERT INTO airline.class_services_dim
SELECT source.class_service_id as class_of_services_id, source.class_purchased, source.class_flown, source.class_change_indicator
FROM tmp_db.tmp_class_services source
LEFT JOIN airline.class_services_dim target ON source.class_service_id = target.class_of_services_id
WHERE target.class_of_services_id IS NULL;

-- Incremntal load from promotion_dim table
INSERT INTO airline.promotion_dim
SELECT source.promotion_id, source.start_date as valid_from, source.end_date as valid_to, source.max_discount_amount as maximum_fare_discount, source.discount_percentage as promotion_percentage, source.category
FROM tmp_db.tmp_promotion source
LEFT JOIN airline.promotion_dim target ON source.promotion_id = target.promotion_id
WHERE target.promotion_id IS NULL;

-- Incremental Load for customer_dim table 
-- Updating values of partition columns is not supported (state=42000,code=10292)
-- 1: Mark changed records as expired
UPDATE airline.customer_dim
SET 
    end_date = CURRENT_DATE,
    is_current = 'N'
WHERE passenger_id IN (
    SELECT s.passenger_id
    FROM tmp_db.tmp_PASSENGER s
    JOIN airline.customer_dim t ON s.passenger_id = t.passenger_id
    WHERE t.is_current = 'Y'
    AND (
        CONCAT(s.first_name, ' ', s.last_name) != t.passenger_name OR
        s.date_of_birth != t.passenger_dateOfBirth OR
        s.gender != t.passenger_gender OR
        COALESCE(s.city, '') != COALESCE(t.passenger_address, '') OR
        COALESCE(s.phone, '') != COALESCE(t.passenger_phone, '') OR
        COALESCE(s.frequent_flyer_points, 0) != COALESCE(t.passenger_points, 0) OR
        COALESCE(s.membership_tier, '') != COALESCE(t.passenger_status, '')
    )
)
AND is_current = 'Y';

-- 2: Insert new versions of changed records plus brand new records
INSERT INTO airline.customer_dim
SELECT 
    s.passenger_id,
    CONCAT(s.first_name, ' ', s.last_name) AS passenger_name,
    s.date_of_birth AS passenger_dateOfBirth,
    s.gender AS passenger_gender,
    s.city AS passenger_address,
    s.phone AS passenger_phone,
    COALESCE(s.frequent_flyer_points, 0) AS passenger_points,
    s.membership_tier AS passenger_status,
    CURRENT_DATE AS start_date,
    NULL AS end_date,
    'Y' AS is_current,
    YEAR(CURRENT_DATE) AS start_year
FROM tmp_db.tmp_PASSENGER s
LEFT JOIN airline.customer_dim t ON s.passenger_id = t.passenger_id AND t.is_current = 'Y'
WHERE 
    t.passenger_id IS NULL  -- New records
    OR (
        t.passenger_id IS NOT NULL AND (
        CONCAT(s.first_name, ' ', s.last_name) != t.passenger_name OR
        s.date_of_birth != t.passenger_dateOfBirth OR
        s.gender != t.passenger_gender OR
        COALESCE(s.address, '') != COALESCE(t.passenger_address, '') OR
        COALESCE(s.phone, '') != COALESCE(t.passenger_phone, '') OR
        COALESCE(s.frequent_flyer_points, 0) != COALESCE(t.passenger_points, 0) OR
        COALESCE(s.membership_tier, '') != COALESCE(t.passenger_status, '')
    )
);


