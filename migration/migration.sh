# migrate aircraft_dim 
sqoop import \
--connect jdbc:oracle:thin:@//oracle_db:1521/FREEPDB1 \
--username airline \
--password airline \
--table aircraft_dim \
--columns "aircraft_id,aircraft_name,number_of_seats,aircraft_model,manufacture_year" \
--num-mappers 2 \
--target-dir /airline-staging-area/aircraft_dim \
--delete-target-dir \
--as-textfile \
--split-by aircraft_id

# ---------------------------------------------------------------------------------------------------------------

# migrate airport_dim 
sqoop import \
--connect jdbc:oracle:thin:@//oracle_db:1521/FREEPDB1 \
--username airline \
--password airline \
--table airport_dim \
--columns "airport_id, airport_code, airport_name, airport_city, airport_location" \
--num-mappers 2 \
--target-dir /airline-staging-area/airport_dim \
--delete-target-dir \
--as-textfile \
--split-by airport_id

# ---------------------------------------------------------------------------------------------------------------

# migrate trip_status_dim 
sqoop import \
--connect jdbc:oracle:thin:@//oracle_db:1521/FREEPDB1 \
--username airline \
--password airline \
--table trip_status_dim \
--columns "status_id, reservation_status, cancellation_reason" \
--num-mappers 2 \
--target-dir /airline-staging-area/trip_status_dim \
--delete-target-dir \
--as-textfile \
--split-by status_id

# ---------------------------------------------------------------------------------------------------------------

# migrate class_services_dim
sqoop import \
--connect jdbc:oracle:thin:@//oracle_db:1521/FREEPDB1 \
--username airline \
--password airline \
--table class_services_dim \
--columns "class_of_services_id, class_purchased, class_flown, class_change_indicator" \
--num-mappers 2 \
--target-dir /airline-staging-area/class_services_dim \
--delete-target-dir \
--as-textfile \
--split-by class_of_services_id

# ---------------------------------------------------------------------------------------------------------------

# migrate promotion_dim
sqoop import \
--connect jdbc:oracle:thin:@//oracle_db:1521/FREEPDB1 \
--username airline \
--password airline \
--table promotion_dim \
--columns "promotion_id, valid_from, valid_to, maximum_fare_discount, promotion_percentage, category" \
--num-mappers 2 \
--target-dir /airline-staging-area/promotion_dim \
--delete-target-dir \
--as-textfile \
--split-by promotion_id

# ---------------------------------------------------------------------------------------------------------------

# migrate time_dim
sqoop import \
--connect jdbc:oracle:thin:@//oracle_db:1521/FREEPDB1 \
--username airline \
--password airline \
--table time_dim \
--columns "time_id, hour, minute, hour_description" \
--num-mappers 2 \
--target-dir /airline-staging-area/time_dim \
--delete-target-dir \
--as-textfile \
--split-by time_id

# ---------------------------------------------------------------------------------------------------------------

# migrate date_dim
sqoop import \
--connect jdbc:oracle:thin:@//oracle_db:1521/FREEPDB1 \
--username airline \
--password airline \
--table date_dim \
--columns "date_id, year, quarter, month, day_of_week, day_of_month, day_of_year, week_of_year, is_holiday" \
--num-mappers 2 \
--target-dir /airline-staging-area/date_dim \
--delete-target-dir \
--as-textfile \
--split-by date_id

# ---------------------------------------------------------------------------------------------------------------

# migrate customer_dim
sqoop import \
--connect jdbc:oracle:thin:@//oracle_db:1521/FREEPDB1 \
--username airline \
--password airline \
--table customer_dim \
--columns "sk_passenger_id, passenger_id, passenger_name, passenger_dateOfBirth, passenger_gender, passenger_address, passenger_phone, passenger_points, passenger_status, start_date, end_date, is_current" \
--num-mappers 4 \
--target-dir /airline-staging-area/customer_dim \
--delete-target-dir \
--as-textfile \
--split-by sk_passenger_id

# ---------------------------------------------------------------------------------------------------------------

# migrate flight_dim
sqoop import \
--connect jdbc:oracle:thin:@//oracle_db:1521/FREEPDB1 \
--username airline \
--password airline \
--table flight_dim \
--columns "flight_id, origin_airport_id, destination_airport_id, origin_date, origin_time, arrival_date, arrival_time, aircraft_id, segment_miles, miles_earned" \
--num-mappers 4 \
--target-dir /airline-staging-area/flight_dim \
--delete-target-dir \
--as-textfile \
--split-by flight_id

# ---------------------------------------------------------------------------------------------------------------

# migrate SegmentActivityFact
sqoop import \
--connect jdbc:oracle:thin:@//oracle_db:1521/FREEPDB1 \
--username airline \
--password airline \
--table SegmentActivityFact \
--columns "passenger_id, class_services_id, promotion_id, flight_id, status_id, ticket_number, overnight_stay, revenue_amount, cancellation_fees, refund_amount, date_id, time_id" \
--num-mappers 4 \
--target-dir /airline-staging-area/SegmentActivityFact \
--delete-target-dir \
--as-textfile \
--split-by passenger_id