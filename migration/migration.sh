# migrate aircraft_dim 
sqoop import \
--connect jdbc:oracle:thin:@//oracle_db:1521/FREEPDB1 \
--username airline \
--password airline \
--query "SELECT aircraft_id, aircraft_name, number_of_seats, aircraft_model, manufacture_year FROM aircraft_dim WHERE \$CONDITIONS" \
--num-mappers 1 \
--target-dir /tmp/aircraft_dim \
--delete-target-dir \
--driver oracle.jdbc.OracleDriver \
--as-textfile

# ---------------------------------------------------------------------------------------------------------------

# migrate airport_dim 
sqoop import \
--connect jdbc:oracle:thin:@//oracle_db:1521/FREEPDB1 \
--username airline \
--password airline \
--query "SELECT airport_id, airport_code, airport_name, airport_city, airport_location FROM airport_dim WHERE \$CONDITIONS" \
--num-mappers 1 \
--target-dir /tmp/airport_dim \
--delete-target-dir \
--driver oracle.jdbc.OracleDriver \
--as-textfile

# ---------------------------------------------------------------------------------------------------------------

# migrate trip_status_dim 
sqoop import \
--connect jdbc:oracle:thin:@//oracle_db:1521/FREEPDB1 \
--username airline \
--password airline \
--query "SELECT status_id, reservation_status, cancellation_reason FROM trip_status_dim WHERE \$CONDITIONS" \
--num-mappers 1 \
--target-dir /tmp/trip_status_dim \
--delete-target-dir \
--driver oracle.jdbc.OracleDriver \
--as-textfile

# ---------------------------------------------------------------------------------------------------------------

# migrate class_services_dim
sqoop import \
--connect jdbc:oracle:thin:@//oracle_db:1521/FREEPDB1 \
--username airline \
--password airline \
--query "SELECT class_of_services_id, class_purchased, class_flown, class_change_indicator FROM class_services_dim WHERE \$CONDITIONS" \
--num-mappers 1 \
--target-dir /tmp/class_services_dim \
--delete-target-dir \
--driver oracle.jdbc.OracleDriver \
--as-textfile 

# ---------------------------------------------------------------------------------------------------------------

# migrate promotion_dim
sqoop import \
--connect jdbc:oracle:thin:@//oracle_db:1521/FREEPDB1 \
--username airline \
--password airline \
--query "SELECT promotion_id, valid_from, valid_to, maximum_fare_discount, promotion_percentage, category FROM promotion_dim WHERE \$CONDITIONS" \
--num-mappers 1 \
--target-dir /tmp/promotion_dim \
--delete-target-dir \
--driver oracle.jdbc.OracleDriver \
--as-textfile

# ---------------------------------------------------------------------------------------------------------------

# migrate time_dim
sqoop import \
--connect jdbc:oracle:thin:@//oracle_db:1521/FREEPDB1 \
--username airline \
--password airline \
--query "SELECT time_id, hour, minute, hour_description FROM time_dim WHERE \$CONDITIONS" \
--num-mappers 1 \
--target-dir /tmp/time_dim \
--delete-target-dir \
--driver oracle.jdbc.OracleDriver \
--as-textfile

# ---------------------------------------------------------------------------------------------------------------

# migrate date_dim
sqoop import \
--connect jdbc:oracle:thin:@//oracle_db:1521/FREEPDB1 \
--username airline \
--password airline \
--query "SELECT date_id, year, quarter, month, day_of_week, day_of_month, day_of_year, week_of_year, is_holiday FROM date_dim WHERE \$CONDITIONS" \
--num-mappers 1 \
--target-dir /tmp/date_dim \
--delete-target-dir \
--driver oracle.jdbc.OracleDriver \
--as-textfile

# ---------------------------------------------------------------------------------------------------------------

# migrate customer_dim
sqoop import \
--connect jdbc:oracle:thin:@//oracle_db:1521/FREEPDB1 \
--username airline \
--password airline \
--query "SELECT sk_passenger_id, passenger_id, passenger_name, passenger_dateOfBirth, passenger_gender, passenger_address, passenger_phone, passenger_points, passenger_status, start_date, end_date, is_current FROM customer_dim WHERE \$CONDITIONS" \
--num-mappers 1 \
--target-dir /tmp/customer_dim \
--delete-target-dir \
--driver oracle.jdbc.OracleDriver \
--as-textfile

# ---------------------------------------------------------------------------------------------------------------

# migrate flight_dim
sqoop import \
--connect jdbc:oracle:thin:@//oracle_db:1521/FREEPDB1 \
--username airline \
--password airline \
--query "SELECT flight_id, origin_airport_id, destination_airport_id, origin_date, origin_time, arrival_date, arrival_time, aircraft_id, segment_miles, miles_earned FROM flight_dim WHERE \$CONDITIONS" \
--num-mappers 1 \
--target-dir /tmp/flight_dim \
--delete-target-dir \
--driver oracle.jdbc.OracleDriver \
--as-textfile

# ---------------------------------------------------------------------------------------------------------------

# migrate SegmentActivityFact
sqoop import \
--connect jdbc:oracle:thin:@//oracle_db:1521/FREEPDB1 \
--username airline \
--password airline \
--query "SELECT passenger_id, class_services_id, promotion_id, flight_id, status_id, ticket_number, overnight_stay, revenue_amount, cancellation_fees, refund_amount, date_id, time_id FROM SegmentActivityFact WHERE \$CONDITIONS" \
--num-mappers 1 \
--target-dir /tmp/SegmentActivityFact \
--delete-target-dir \
--driver oracle.jdbc.OracleDriver \
--as-textfile
