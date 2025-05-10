INSERT ALL
    INTO aircraft_dim (aircraft_id, aircraft_name, number_of_seats, aircraft_model, manufacture_year) VALUES (1, 'EgyptAir Boeing 737', 160, 'Boeing 737-800', 2015)
    INTO aircraft_dim (aircraft_id, aircraft_name, number_of_seats, aircraft_model, manufacture_year) VALUES (2, 'EgyptAir Airbus A320', 150, 'Airbus A320-200', 2018)
    INTO aircraft_dim (aircraft_id, aircraft_name, number_of_seats, aircraft_model, manufacture_year) VALUES (3, 'EgyptAir Airbus A330', 277, 'Airbus A330-300', 2014)
    INTO aircraft_dim (aircraft_id, aircraft_name, number_of_seats, aircraft_model, manufacture_year) VALUES (4, 'EgyptAir Boeing 777', 346, 'Boeing 777-300ER', 2013)
    INTO aircraft_dim (aircraft_id, aircraft_name, number_of_seats, aircraft_model, manufacture_year) VALUES (5, 'EgyptAir Embraer E170', 76, 'Embraer E170', 2017)
    INTO aircraft_dim (aircraft_id, aircraft_name, number_of_seats, aircraft_model, manufacture_year) VALUES (6, 'Nile Air Airbus A320', 164, 'Airbus A320-200', 2016)
    INTO aircraft_dim (aircraft_id, aircraft_name, number_of_seats, aircraft_model, manufacture_year) VALUES (7, 'Nile Air Airbus A321', 200, 'Airbus A321-200', 2017)
    INTO aircraft_dim (aircraft_id, aircraft_name, number_of_seats, aircraft_model, manufacture_year) VALUES (8, 'Air Cairo Airbus A320', 180, 'Airbus A320-200', 2019)
    INTO aircraft_dim (aircraft_id, aircraft_name, number_of_seats, aircraft_model, manufacture_year) VALUES (9, 'Air Cairo Embraer E190', 120, 'Embraer E190', 2020)
    INTO aircraft_dim (aircraft_id, aircraft_name, number_of_seats, aircraft_model, manufacture_year) VALUES (10, 'FlyEgypt Boeing 737', 189, 'Boeing 737-800', 2019)
    INTO aircraft_dim (aircraft_id, aircraft_name, number_of_seats, aircraft_model, manufacture_year) VALUES (11, 'EgyptAir Express Embraer E170', 76, 'Embraer E170', 2015)
    INTO aircraft_dim (aircraft_id, aircraft_name, number_of_seats, aircraft_model, manufacture_year) VALUES (12, 'Air Arabia Egypt Airbus A320', 168, 'Airbus A320-200', 2021)
    INTO aircraft_dim (aircraft_id, aircraft_name, number_of_seats, aircraft_model, manufacture_year) VALUES (13, 'FlyEgypt Boeing 737 MAX', 210, 'Boeing 737 MAX 8', 2022)
    INTO aircraft_dim (aircraft_id, aircraft_name, number_of_seats, aircraft_model, manufacture_year) VALUES (14, 'EgyptAir Cargo Airbus A330', 70, 'Airbus A330-200F', 2018)
    INTO aircraft_dim (aircraft_id, aircraft_name, number_of_seats, aircraft_model, manufacture_year) VALUES (15, 'Air Cairo Boeing 737', 190, 'Boeing 737-800', 2018)
    INTO aircraft_dim (aircraft_id, aircraft_name, number_of_seats, aircraft_model, manufacture_year) VALUES (16, 'EgyptAir Cargo Boeing 777', 102, 'Boeing 777F', 2020)
    INTO aircraft_dim (aircraft_id, aircraft_name, number_of_seats, aircraft_model, manufacture_year) VALUES (17, 'EgyptAir Boeing 787', 296, 'Boeing 787-9 Dreamliner', 2021)
    INTO aircraft_dim (aircraft_id, aircraft_name, number_of_seats, aircraft_model, manufacture_year) VALUES (18, 'Nile Air Boeing 737', 162, 'Boeing 737-800', 2016)
    INTO aircraft_dim (aircraft_id, aircraft_name, number_of_seats, aircraft_model, manufacture_year) VALUES (19, 'EgyptAir Airbus A220', 140, 'Airbus A220-300', 2020)
    INTO aircraft_dim (aircraft_id, aircraft_name, number_of_seats, aircraft_model, manufacture_year) VALUES (20, 'EgyptAir Airbus A350', 314, 'Airbus A350-900', 2022)
SELECT 1 FROM DUAL;

COMMIT;

-- Create airport_dim Data
INSERT INTO airport_dim (airport_id, airport_code, airport_name, airport_city, airport_location) VALUES (1, 'CAI', 'Cairo International Airport', 'Cairo', 'Egypt');
INSERT INTO airport_dim (airport_id, airport_code, airport_name, airport_city, airport_location) VALUES (2, 'HRG', 'Hurghada International Airport', 'Hurghada', 'Egypt');
INSERT INTO airport_dim (airport_id, airport_code, airport_name, airport_city, airport_location) VALUES (3, 'SSH', 'Sharm El Sheikh International Airport', 'Sharm El Sheikh', 'Egypt');
INSERT INTO airport_dim (airport_id, airport_code, airport_name, airport_city, airport_location) VALUES (4, 'LXR', 'Luxor International Airport', 'Luxor', 'Egypt');
INSERT INTO airport_dim (airport_id, airport_code, airport_name, airport_city, airport_location) VALUES (5, 'ASW', 'Aswan International Airport', 'Aswan', 'Egypt');
INSERT INTO airport_dim (airport_id, airport_code, airport_name, airport_city, airport_location) VALUES (6, 'ALY', 'Alexandria International Airport', 'Alexandria', 'Egypt');
INSERT INTO airport_dim (airport_id, airport_code, airport_name, airport_city, airport_location) VALUES (7, 'SPX', 'Sphinx International Airport', 'Giza', 'Egypt');
INSERT INTO airport_dim (airport_id, airport_code, airport_name, airport_city, airport_location) VALUES (8, 'HBE', 'Borg El Arab International Airport', 'Alexandria', 'Egypt');
INSERT INTO airport_dim (airport_id, airport_code, airport_name, airport_city, airport_location) VALUES (9, 'DBB', 'Al Alamain International Airport', 'El Alamein', 'Egypt');
INSERT INTO airport_dim (airport_id, airport_code, airport_name, airport_city, airport_location) VALUES (10, 'TCP', 'Taba International Airport', 'Taba', 'Egypt');

COMMIT;

-- Create customer_dim data
INSERT ALL
    INTO customer_dim VALUES (1,1, 'Ahmed Mohamed', TO_DATE('1985-06-15', 'YYYY-MM-DD'), 'Male', 'Cairo, Egypt', '01001234567', 1200, 'Gold', TO_DATE('2024-01-01', 'YYYY-MM-DD'), TO_DATE('9999-12-31', 'YYYY-MM-DD'), 'Y')
    INTO customer_dim VALUES (2,2, 'Sara Ahmed', TO_DATE('1990-12-20', 'YYYY-MM-DD'), 'Female', 'Alexandria, Egypt', '01009876543', 800, 'Silver', TO_DATE('2023-07-15', 'YYYY-MM-DD'), TO_DATE('9999-12-31', 'YYYY-MM-DD'), 'Y')
    INTO customer_dim VALUES (3,3, 'Mohamed Hassan', TO_DATE('1978-08-05', 'YYYY-MM-DD'), 'Male', 'Giza, Egypt', '01102345678', 1500, 'Platinum', TO_DATE('2022-06-10', 'YYYY-MM-DD'), TO_DATE('9999-12-31', 'YYYY-MM-DD'), 'Y')
    INTO customer_dim VALUES (4,4, 'Nour Amr', TO_DATE('1995-04-22', 'YYYY-MM-DD'), 'Female', 'Aswan, Egypt', '01205678901', 400, 'Bronze', TO_DATE('2021-05-20', 'YYYY-MM-DD'), TO_DATE('9999-12-31', 'YYYY-MM-DD'), 'Y')
    INTO customer_dim VALUES (5,5, 'Khaled Ibrahim', TO_DATE('1983-09-30', 'YYYY-MM-DD'), 'Male', 'Mansoura, Egypt', '01501112233', 1300, 'Gold', TO_DATE('2020-03-12', 'YYYY-MM-DD'), TO_DATE('9999-12-31', 'YYYY-MM-DD'), 'Y')
    INTO customer_dim VALUES (6,6, 'Mariam Saleh', TO_DATE('1992-11-10', 'YYYY-MM-DD'), 'Female', 'Suez, Egypt', '01007654321', 900, 'Silver', TO_DATE('2019-08-25', 'YYYY-MM-DD'), TO_DATE('9999-12-31', 'YYYY-MM-DD'), 'Y')
    INTO customer_dim VALUES (7,7, 'Omar Tarek', TO_DATE('1989-03-05', 'YYYY-MM-DD'), 'Male', 'Luxor, Egypt', '01106543210', 1600, 'Platinum', TO_DATE('2018-04-10', 'YYYY-MM-DD'), TO_DATE('9999-12-31', 'YYYY-MM-DD'), 'Y')
    INTO customer_dim VALUES (8,8, 'Layla Adel', TO_DATE('1997-07-18', 'YYYY-MM-DD'), 'Female', 'Port Said, Egypt', '01203456789', 500, 'Bronze', TO_DATE('2017-09-30', 'YYYY-MM-DD'), TO_DATE('9999-12-31', 'YYYY-MM-DD'), 'Y')
    INTO customer_dim VALUES (9,9, 'Youssef Nabil', TO_DATE('1980-12-02', 'YYYY-MM-DD'), 'Male', 'Zagazig, Egypt', '01507654321', 1100, 'Gold', TO_DATE('2016-06-20', 'YYYY-MM-DD'), TO_DATE('9999-12-31', 'YYYY-MM-DD'), 'Y')
    INTO customer_dim VALUES (10,10, 'Hana Sameh', TO_DATE('1994-05-14', 'YYYY-MM-DD'), 'Female', 'Tanta, Egypt', '01005432176', 750, 'Silver', TO_DATE('2015-02-18', 'YYYY-MM-DD'), TO_DATE('9999-12-31', 'YYYY-MM-DD'), 'Y')
    INTO customer_dim VALUES (11,11, 'Hassan Youssef', TO_DATE('1987-10-25', 'YYYY-MM-DD'), 'Male', 'Fayoum, Egypt', '01003456789', 950, 'Silver', TO_DATE('2014-08-12', 'YYYY-MM-DD'), TO_DATE('9999-12-31', 'YYYY-MM-DD'), 'Y')
    INTO customer_dim VALUES (12,12, 'Amina Khaled', TO_DATE('1996-03-30', 'YYYY-MM-DD'), 'Female', 'Ismailia, Egypt', '01107896543', 600, 'Bronze', TO_DATE('2013-11-05', 'YYYY-MM-DD'), TO_DATE('9999-12-31', 'YYYY-MM-DD'), 'Y')
    INTO customer_dim VALUES (13,13, 'Walid Mahmoud', TO_DATE('1982-07-18', 'YYYY-MM-DD'), 'Male', 'Damietta, Egypt', '01204567891', 1400, 'Gold', TO_DATE('2012-09-22', 'YYYY-MM-DD'), TO_DATE('9999-12-31', 'YYYY-MM-DD'), 'Y')
    INTO customer_dim VALUES (14,14, 'Rania Hatem', TO_DATE('1991-12-10', 'YYYY-MM-DD'), 'Female', 'Minya, Egypt', '01506543219', 700, 'Silver', TO_DATE('2011-06-15', 'YYYY-MM-DD'), TO_DATE('9999-12-31', 'YYYY-MM-DD'), 'Y')
    INTO customer_dim VALUES (15,15, 'Tarek Salah', TO_DATE('1979-05-05', 'YYYY-MM-DD'), 'Male', 'Beni Suef, Egypt', '01007654320', 1700, 'Platinum', TO_DATE('2010-04-30', 'YYYY-MM-DD'), TO_DATE('9999-12-31', 'YYYY-MM-DD'), 'Y')
    INTO customer_dim VALUES (16,16, 'Mona Nader', TO_DATE('1998-08-21', 'YYYY-MM-DD'), 'Female', 'Sohag, Egypt', '01104356782', 450, 'Bronze', TO_DATE('2009-07-18', 'YYYY-MM-DD'), TO_DATE('9999-12-31', 'YYYY-MM-DD'), 'Y')
    INTO customer_dim VALUES (17,17, 'Mostafa Adel', TO_DATE('1986-02-14', 'YYYY-MM-DD'), 'Male', 'Qena, Egypt', '01203456780', 1250, 'Gold', TO_DATE('2008-03-25', 'YYYY-MM-DD'), TO_DATE('9999-12-31', 'YYYY-MM-DD'), 'Y')
    INTO customer_dim VALUES (18,18, 'Salma Tamer', TO_DATE('1993-09-11', 'YYYY-MM-DD'), 'Female', 'Hurghada, Egypt', '01502345678', 850, 'Silver', TO_DATE('2007-12-05', 'YYYY-MM-DD'), TO_DATE('9999-12-31', 'YYYY-MM-DD'), 'Y')
    INTO customer_dim VALUES (19,19, 'Yasser Fathy', TO_DATE('1984-06-07', 'YYYY-MM-DD'), 'Male', 'Sharm El Sheikh, Egypt', '01001234568', 1550, 'Platinum', TO_DATE('2006-10-10', 'YYYY-MM-DD'), TO_DATE('9999-12-31', 'YYYY-MM-DD'), 'Y')
    INTO customer_dim VALUES (20,20, 'Heba Magdy', TO_DATE('1999-01-29', 'YYYY-MM-DD'), 'Female', 'Matrouh, Egypt', '01107895432', 500, 'Bronze', TO_DATE('2005-05-15', 'YYYY-MM-DD'), TO_DATE('9999-12-31', 'YYYY-MM-DD'), 'Y')
    INTO customer_dim VALUES (21,21, 'Ahmed Shokry', TO_DATE('1988-11-12', 'YYYY-MM-DD'), 'Male', 'Alexandria, Egypt', '01005678912', 1100, 'Gold', TO_DATE('2014-02-20', 'YYYY-MM-DD'), TO_DATE('9999-12-31', 'YYYY-MM-DD'), 'Y')
    INTO customer_dim VALUES (22,22, 'Nourhan Saeed', TO_DATE('1995-07-28', 'YYYY-MM-DD'), 'Female', 'Giza, Egypt', '01109876543', 750, 'Silver', TO_DATE('2013-05-15', 'YYYY-MM-DD'), TO_DATE('9999-12-31', 'YYYY-MM-DD'), 'Y')
    INTO customer_dim VALUES (23,23, 'Ibrahim Khalil', TO_DATE('1980-04-03', 'YYYY-MM-DD'), 'Male', 'Aswan, Egypt', '01206789012', 1600, 'Platinum', TO_DATE('2012-10-10', 'YYYY-MM-DD'), TO_DATE('9999-12-31', 'YYYY-MM-DD'), 'Y')
    INTO customer_dim VALUES (24,24, 'Heba El-Sayed', TO_DATE('1992-09-17', 'YYYY-MM-DD'), 'Female', 'Mansoura, Egypt', '01507896532', 900, 'Silver', TO_DATE('2011-08-08', 'YYYY-MM-DD'), TO_DATE('9999-12-31', 'YYYY-MM-DD'), 'Y')
    INTO customer_dim VALUES (25,25, 'Khaled Fathy', TO_DATE('1985-01-22', 'YYYY-MM-DD'), 'Male', 'Zagazig, Egypt', '01003456721', 1300, 'Gold', TO_DATE('2010-07-05', 'YYYY-MM-DD'), TO_DATE('9999-12-31', 'YYYY-MM-DD'), 'Y')
    INTO customer_dim VALUES (26,26, 'Mai Tamer', TO_DATE('1997-06-14', 'YYYY-MM-DD'), 'Female', 'Qena, Egypt', '01108765432', 550, 'Bronze', TO_DATE('2009-03-25', 'YYYY-MM-DD'), TO_DATE('9999-12-31', 'YYYY-MM-DD'), 'Y')
    INTO customer_dim VALUES (27,27, 'Mohamed Galal', TO_DATE('1978-12-05', 'YYYY-MM-DD'), 'Male', 'Ismailia, Egypt', '01203456123', 1800, 'Platinum', TO_DATE('2008-11-12', 'YYYY-MM-DD'), TO_DATE('9999-12-31', 'YYYY-MM-DD'), 'Y')
    INTO customer_dim VALUES (28,28, 'Laila Hossam', TO_DATE('1994-03-19', 'YYYY-MM-DD'), 'Female', 'Tanta, Egypt', '01502345671', 800, 'Silver', TO_DATE('2007-06-18', 'YYYY-MM-DD'), TO_DATE('9999-12-31', 'YYYY-MM-DD'), 'Y')
    INTO customer_dim VALUES (29,29, 'Youssef Nabil', TO_DATE('1983-08-07', 'YYYY-MM-DD'), 'Male', 'Minya, Egypt', '01001234529', 1450, 'Gold', TO_DATE('2006-09-22', 'YYYY-MM-DD'), TO_DATE('9999-12-31', 'YYYY-MM-DD'), 'Y')
    INTO customer_dim VALUES (30,30, 'Sara Adel', TO_DATE('2000-02-01', 'YYYY-MM-DD'), 'Female', 'Damietta, Egypt', '01107895421', 480, 'Bronze', TO_DATE('2005-04-30', 'YYYY-MM-DD'), TO_DATE('9999-12-31', 'YYYY-MM-DD'), 'Y')
SELECT 1 FROM DUAL;

COMMIT;

--trip status dim data

INSERT ALL
    INTO trip_status_dim (status_id, reservation_status, cancellation_reason) VALUES (1, 'Confirmed', NULL)
    INTO trip_status_dim (status_id, reservation_status, cancellation_reason) VALUES (2, 'Completed', NULL)
    INTO trip_status_dim (status_id, reservation_status, cancellation_reason) VALUES (3, 'Cancelled', 'Customer Request')
    INTO trip_status_dim (status_id, reservation_status, cancellation_reason) VALUES (4, 'Cancelled', 'Bad Weather')
    INTO trip_status_dim (status_id, reservation_status, cancellation_reason) VALUES (5, 'Cancelled', 'Technical Issues')
    INTO trip_status_dim (status_id, reservation_status, cancellation_reason) VALUES (6, 'Pending', NULL)
    INTO trip_status_dim (status_id, reservation_status, cancellation_reason) VALUES (7, 'No Show', 'Passenger Did Not Arrive')
    INTO trip_status_dim (status_id, reservation_status, cancellation_reason) VALUES (8, 'Delayed', 'Air Traffic Control Restriction')
    INTO trip_status_dim (status_id, reservation_status, cancellation_reason) VALUES (9, 'Delayed', 'Mechanical Issue')
    INTO trip_status_dim (status_id, reservation_status, cancellation_reason) VALUES (10, 'Cancelled', 'Pilot Unavailability')
    INTO trip_status_dim (status_id, reservation_status, cancellation_reason) VALUES (11, 'Cancelled', 'Insufficient Passengers')
    INTO trip_status_dim (status_id, reservation_status, cancellation_reason) VALUES (12, 'Cancelled', 'Security Threat')
    INTO trip_status_dim (status_id, reservation_status, cancellation_reason) VALUES (13, 'Confirmed', NULL)
    INTO trip_status_dim (status_id, reservation_status, cancellation_reason) VALUES (14, 'Completed', NULL)
    INTO trip_status_dim (status_id, reservation_status, cancellation_reason) VALUES (15, 'Cancelled', 'Customer Request')
    INTO trip_status_dim (status_id, reservation_status, cancellation_reason) VALUES (16, 'Cancelled', 'Bad Weather')
    INTO trip_status_dim (status_id, reservation_status, cancellation_reason) VALUES (17, 'Pending', NULL)
    INTO trip_status_dim (status_id, reservation_status, cancellation_reason) VALUES (18, 'No Show', 'Passenger Did Not Arrive')
    INTO trip_status_dim (status_id, reservation_status, cancellation_reason) VALUES (19, 'Delayed', 'Runway Closure')
    INTO trip_status_dim (status_id, reservation_status, cancellation_reason) VALUES (20, 'Delayed', 'Crew Scheduling Issues')
    INTO trip_status_dim (status_id, reservation_status, cancellation_reason) VALUES (21, 'Cancelled', 'Aircraft Maintenance')
    INTO trip_status_dim (status_id, reservation_status, cancellation_reason) VALUES (22, 'Cancelled', 'Operational Issues')
    INTO trip_status_dim (status_id, reservation_status, cancellation_reason) VALUES (23, 'Pending', NULL)
    INTO trip_status_dim (status_id, reservation_status, cancellation_reason) VALUES (24, 'No Show', 'Missed Connection')
    INTO trip_status_dim (status_id, reservation_status, cancellation_reason) VALUES (25, 'Confirmed', NULL)
    INTO trip_status_dim (status_id, reservation_status, cancellation_reason) VALUES (26, 'Completed', NULL)
    INTO trip_status_dim (status_id, reservation_status, cancellation_reason) VALUES (27, 'Cancelled', 'Customer Request')
    INTO trip_status_dim (status_id, reservation_status, cancellation_reason) VALUES (28, 'Cancelled', 'Airline Strike')
    INTO trip_status_dim (status_id, reservation_status, cancellation_reason) VALUES (29, 'Pending', NULL)
    INTO trip_status_dim (status_id, reservation_status, cancellation_reason) VALUES (30, 'No Show', 'Passenger Didn’t Check-in')
    INTO trip_status_dim (status_id, reservation_status, cancellation_reason) VALUES (31, 'Delayed', 'Refueling Delay')
    INTO trip_status_dim (status_id, reservation_status, cancellation_reason) VALUES (32, 'Delayed', 'Late Arrival of Aircraft')
    INTO trip_status_dim (status_id, reservation_status, cancellation_reason) VALUES (33, 'Cancelled', 'Medical Emergency')
    INTO trip_status_dim (status_id, reservation_status, cancellation_reason) VALUES (34, 'Cancelled', 'Overbooking')
    INTO trip_status_dim (status_id, reservation_status, cancellation_reason) VALUES (35, 'Pending', NULL)
    INTO trip_status_dim (status_id, reservation_status, cancellation_reason) VALUES (36, 'No Show', 'Visa Issues')
    INTO trip_status_dim (status_id, reservation_status, cancellation_reason) VALUES (37, 'Confirmed', NULL)
    INTO trip_status_dim (status_id, reservation_status, cancellation_reason) VALUES (38, 'Completed', NULL)
    INTO trip_status_dim (status_id, reservation_status, cancellation_reason) VALUES (39, 'Cancelled', 'Customer Request')
    INTO trip_status_dim (status_id, reservation_status, cancellation_reason) VALUES (40, 'Cancelled', 'Political Unrest')
    INTO trip_status_dim (status_id, reservation_status, cancellation_reason) VALUES (41, 'Pending', NULL)
    INTO trip_status_dim (status_id, reservation_status, cancellation_reason) VALUES (42, 'No Show', 'Traffic Delay')
    INTO trip_status_dim (status_id, reservation_status, cancellation_reason) VALUES (43, 'Delayed', 'Airline Technical Issues')
    INTO trip_status_dim (status_id, reservation_status, cancellation_reason) VALUES (44, 'Delayed', 'Regulatory Hold')
    INTO trip_status_dim (status_id, reservation_status, cancellation_reason) VALUES (45, 'Cancelled', 'Natural Disaster')
    INTO trip_status_dim (status_id, reservation_status, cancellation_reason) VALUES (46, 'Cancelled', 'Loss of Luggage')
    INTO trip_status_dim (status_id, reservation_status, cancellation_reason) VALUES (47, 'Pending', NULL)
    INTO trip_status_dim (status_id, reservation_status, cancellation_reason) VALUES (48, 'No Show', 'Flight Reschedule')
    INTO trip_status_dim (status_id, reservation_status, cancellation_reason) VALUES (49, 'Confirmed', NULL)
    INTO trip_status_dim (status_id, reservation_status, cancellation_reason) VALUES (50, 'Completed', NULL)
    INTO trip_status_dim (status_id, reservation_status, cancellation_reason) VALUES (51, 'Cancelled', 'Customer Request')
    INTO trip_status_dim (status_id, reservation_status, cancellation_reason) VALUES (52, 'Cancelled', 'Security Clearance Delay')
SELECT * FROM dual;

Commit;

-- Insert data with "Upgrade", "Downgrade", or "No Change"
INSERT ALL
    INTO class_services_dim (class_of_services_id, class_purchased, class_flown, class_change_indicator) VALUES (1, 'Economy', 'Economy', 'No Change')
    INTO class_services_dim (class_of_services_id, class_purchased, class_flown, class_change_indicator) VALUES (2, 'Business', 'Business', 'No Change')
    INTO class_services_dim (class_of_services_id, class_purchased, class_flown, class_change_indicator) VALUES (3, 'First Class', 'First Class', 'No Change')
    INTO class_services_dim (class_of_services_id, class_purchased, class_flown, class_change_indicator) VALUES (4, 'Economy', 'Business', 'Upgrade')
    INTO class_services_dim (class_of_services_id, class_purchased, class_flown, class_change_indicator) VALUES (5, 'Business', 'First Class', 'Upgrade')
    INTO class_services_dim (class_of_services_id, class_purchased, class_flown, class_change_indicator) VALUES (6, 'Business', 'Economy', 'Downgrade')
    INTO class_services_dim (class_of_services_id, class_purchased, class_flown, class_change_indicator) VALUES (7, 'First Class', 'Business', 'Downgrade')
    INTO class_services_dim (class_of_services_id, class_purchased, class_flown, class_change_indicator) VALUES (8, 'Economy', 'Economy', 'No Change')
    INTO class_services_dim (class_of_services_id, class_purchased, class_flown, class_change_indicator) VALUES (9, 'Business', 'Business', 'No Change')
    INTO class_services_dim (class_of_services_id, class_purchased, class_flown, class_change_indicator) VALUES (10, 'Economy', 'Business', 'Upgrade')
    INTO class_services_dim (class_of_services_id, class_purchased, class_flown, class_change_indicator) VALUES (11, 'Business', 'First Class', 'Upgrade')
    INTO class_services_dim (class_of_services_id, class_purchased, class_flown, class_change_indicator) VALUES (12, 'Economy', 'Economy', 'No Change')
    INTO class_services_dim (class_of_services_id, class_purchased, class_flown, class_change_indicator) VALUES (13, 'Economy', 'Economy', 'No Change')
    INTO class_services_dim (class_of_services_id, class_purchased, class_flown, class_change_indicator) VALUES (14, 'Business', 'Business', 'No Change')
    INTO class_services_dim (class_of_services_id, class_purchased, class_flown, class_change_indicator) VALUES (15, 'First Class', 'First Class', 'No Change')
    INTO class_services_dim (class_of_services_id, class_purchased, class_flown, class_change_indicator) VALUES (16, 'Economy', 'Business', 'Upgrade')
    INTO class_services_dim (class_of_services_id, class_purchased, class_flown, class_change_indicator) VALUES (17, 'Business', 'First Class', 'Upgrade')
    INTO class_services_dim (class_of_services_id, class_purchased, class_flown, class_change_indicator) VALUES (18, 'Economy', 'Economy', 'No Change')
    INTO class_services_dim (class_of_services_id, class_purchased, class_flown, class_change_indicator) VALUES (19, 'Business', 'Economy', 'Downgrade')
    INTO class_services_dim (class_of_services_id, class_purchased, class_flown, class_change_indicator) VALUES (20, 'First Class', 'Business', 'Downgrade')
    INTO class_services_dim (class_of_services_id, class_purchased, class_flown, class_change_indicator) VALUES (21, 'Economy', 'Business', 'Upgrade')
    INTO class_services_dim (class_of_services_id, class_purchased, class_flown, class_change_indicator) VALUES (22, 'Business', 'First Class', 'Upgrade')
    INTO class_services_dim (class_of_services_id, class_purchased, class_flown, class_change_indicator) VALUES (23, 'Economy', 'Economy', 'No Change')
    INTO class_services_dim (class_of_services_id, class_purchased, class_flown, class_change_indicator) VALUES (24, 'Economy', 'Economy', 'No Change')
    INTO class_services_dim (class_of_services_id, class_purchased, class_flown, class_change_indicator) VALUES (25, 'Business', 'Business', 'No Change')
    INTO class_services_dim (class_of_services_id, class_purchased, class_flown, class_change_indicator) VALUES (26, 'First Class', 'First Class', 'No Change')
    INTO class_services_dim (class_of_services_id, class_purchased, class_flown, class_change_indicator) VALUES (27, 'Economy', 'Business', 'Upgrade')
    INTO class_services_dim (class_of_services_id, class_purchased, class_flown, class_change_indicator) VALUES (28, 'Business', 'First Class', 'Upgrade')
    INTO class_services_dim (class_of_services_id, class_purchased, class_flown, class_change_indicator) VALUES (29, 'Economy', 'Economy', 'No Change')
    INTO class_services_dim (class_of_services_id, class_purchased, class_flown, class_change_indicator) VALUES (30, 'First Class', 'Business', 'Downgrade')
SELECT * FROM dual;

Commit;

--promotion dim data
INSERT ALL
    INTO promotion_dim (promotion_id, valid_from, valid_to, maximum_fare_discount, promotion_percentage, category) 
    VALUES (1, TO_DATE('2024-01-01', 'YYYY-MM-DD'), TO_DATE('2024-03-31', 'YYYY-MM-DD'), 500, 10, 'Seasonal')

    INTO promotion_dim (promotion_id, valid_from, valid_to, maximum_fare_discount, promotion_percentage, category) 
    VALUES (2, TO_DATE('2024-02-01', 'YYYY-MM-DD'), TO_DATE('2024-05-31', 'YYYY-MM-DD'), 300, 5, 'Student Discount')

    INTO promotion_dim (promotion_id, valid_from, valid_to, maximum_fare_discount, promotion_percentage, category) 
    VALUES (3, TO_DATE('2024-06-01', 'YYYY-MM-DD'), TO_DATE('2024-08-31', 'YYYY-MM-DD'), 700, 15, 'Summer Special')

    INTO promotion_dim (promotion_id, valid_from, valid_to, maximum_fare_discount, promotion_percentage, category) 
    VALUES (4, TO_DATE('2024-09-01', 'YYYY-MM-DD'), TO_DATE('2024-12-31', 'YYYY-MM-DD'), 400, 8, 'Autumn Offer')

    INTO promotion_dim (promotion_id, valid_from, valid_to, maximum_fare_discount, promotion_percentage, category) 
    VALUES (5, TO_DATE('2024-11-01', 'YYYY-MM-DD'), TO_DATE('2025-01-15', 'YYYY-MM-DD'), 600, 12, 'Holiday Deal')

    INTO promotion_dim (promotion_id, valid_from, valid_to, maximum_fare_discount, promotion_percentage, category) 
    VALUES (6, TO_DATE('2025-02-01', 'YYYY-MM-DD'), TO_DATE('2025-04-30', 'YYYY-MM-DD'), 350, 7, 'Early Bird')

    INTO promotion_dim (promotion_id, valid_from, valid_to, maximum_fare_discount, promotion_percentage, category) 
    VALUES (7, TO_DATE('2025-06-01', 'YYYY-MM-DD'), TO_DATE('2025-09-01', 'YYYY-MM-DD'), 800, 18, 'Mega Saver')

    INTO promotion_dim (promotion_id, valid_from, valid_to, maximum_fare_discount, promotion_percentage, category) 
    VALUES (8, TO_DATE('2025-10-01', 'YYYY-MM-DD'), TO_DATE('2026-01-31', 'YYYY-MM-DD'), 550, 10, 'End of Year Sale')

    INTO promotion_dim (promotion_id, valid_from, valid_to, maximum_fare_discount, promotion_percentage, category) 
    VALUES (9, TO_DATE('2026-02-01', 'YYYY-MM-DD'), TO_DATE('2026-05-31', 'YYYY-MM-DD'), 450, 9, 'Spring Break')

    INTO promotion_dim (promotion_id, valid_from, valid_to, maximum_fare_discount, promotion_percentage, category) 
    VALUES (10, TO_DATE('2026-07-01', 'YYYY-MM-DD'), TO_DATE('2026-09-30', 'YYYY-MM-DD'), 650, 14, 'Back to School')

    INTO promotion_dim (promotion_id, valid_from, valid_to, maximum_fare_discount, promotion_percentage, category) 
    VALUES (11, TO_DATE('2026-10-15', 'YYYY-MM-DD'), TO_DATE('2026-12-31', 'YYYY-MM-DD'), 900, 20, 'Black Friday')

    INTO promotion_dim (promotion_id, valid_from, valid_to, maximum_fare_discount, promotion_percentage, category) 
    VALUES (12, TO_DATE('2027-01-01', 'YYYY-MM-DD'), TO_DATE('2027-03-31', 'YYYY-MM-DD'), 400, 8, 'Winter Sale')

    INTO promotion_dim (promotion_id, valid_from, valid_to, maximum_fare_discount, promotion_percentage, category) 
    VALUES (13, TO_DATE('2027-04-01', 'YYYY-MM-DD'), TO_DATE('2027-06-30', 'YYYY-MM-DD'), 750, 16, 'Spring Promo')

    INTO promotion_dim (promotion_id, valid_from, valid_to, maximum_fare_discount, promotion_percentage, category) 
    VALUES (14, TO_DATE('2027-07-01', 'YYYY-MM-DD'), TO_DATE('2027-09-30', 'YYYY-MM-DD'), 1000, 25, 'Summer Bonanza')

    INTO promotion_dim (promotion_id, valid_from, valid_to, maximum_fare_discount, promotion_percentage, category) 
    VALUES (15, TO_DATE('2027-10-01', 'YYYY-MM-DD'), TO_DATE('2027-12-31', 'YYYY-MM-DD'), 500, 10, 'Year-End Special')

SELECT * FROM dual;

Commit;


-- Insert data into time_dim
INSERT INTO time_dim (time_id, hour, minute, hour_description)
SELECT 
    -- Generate a timestamp for each row (starting from a specific date, e.g., '1970-01-01 00:00:00')
    TO_TIMESTAMP('2020-01-01 00:00:00', 'YYYY-MM-DD HH24:MI:SS') + NUMTODSINTERVAL((LEVEL - 1) * 30, 'MINUTE') AS time_id,
    MOD(TRUNC((LEVEL - 1) / 2), 24) AS hour,  -- Cycles through 0-23 hours
    CASE MOD(LEVEL - 1, 2) WHEN 0 THEN 0 ELSE 30 END AS minute,  -- Alternates 00 and 30
    CASE 
        WHEN MOD(TRUNC((LEVEL - 1) / 2), 24) = 0 THEN 'Midnight'
        WHEN MOD(TRUNC((LEVEL - 1) / 2), 24) BETWEEN 1 AND 5 THEN 'Early Morning'
        WHEN MOD(TRUNC((LEVEL - 1) / 2), 24) BETWEEN 6 AND 11 THEN 'Morning'
        WHEN MOD(TRUNC((LEVEL - 1) / 2), 24) BETWEEN 12 AND 17 THEN 'Afternoon'
        WHEN MOD(TRUNC((LEVEL - 1) / 2), 24) BETWEEN 18 AND 20 THEN 'Evening'
        WHEN MOD(TRUNC((LEVEL - 1) / 2), 24) BETWEEN 21 AND 23 THEN 'Night'
    END AS hour_description
FROM DUAL
CONNECT BY LEVEL <= 24 * 2;  -- 24 hours * 2 (for 00 and 30 minutes)

Commit;

--date dim data
DECLARE
    TYPE Date_Table IS TABLE OF date_dim%ROWTYPE INDEX BY PLS_INTEGER;
    v_dates Date_Table;
    v_index NUMBER := 1;
    v_start_date DATE := DATE '2020-01-01';  
    v_end_date   DATE := DATE '2020-12-31';  
    v_current_date DATE := v_start_date;
    v_date_id DATE := v_start_date;  -- Change to DATE type
BEGIN
    WHILE v_current_date <= v_end_date LOOP
        v_dates(v_index).date_id := v_date_id;  -- Assign DATE value
        v_dates(v_index).year := EXTRACT(YEAR FROM v_current_date);
        v_dates(v_index).quarter := CEIL(EXTRACT(MONTH FROM v_current_date) / 3);
        v_dates(v_index).month := EXTRACT(MONTH FROM v_current_date);
        v_dates(v_index).day_of_week := TO_NUMBER(TO_CHAR(v_current_date, 'D')) - 1;
        v_dates(v_index).day_of_month := EXTRACT(DAY FROM v_current_date);
        v_dates(v_index).day_of_year := TO_NUMBER(TO_CHAR(v_current_date, 'DDD'));
        v_dates(v_index).week_of_year := TO_NUMBER(TO_CHAR(v_current_date, 'IW'));
        v_dates(v_index).is_holiday := CASE WHEN TO_CHAR(v_current_date, 'MM-DD') IN ('01-01', '12-25') THEN 1 ELSE 0 END;

        v_current_date := v_current_date + 1;
        v_date_id := v_date_id + 1;  -- Increment DATE by 1 day
        v_index := v_index + 1;
    END LOOP;

    FORALL i IN 1..v_dates.COUNT
        INSERT INTO date_dim VALUES v_dates(i);

    COMMIT;
END;
/
Commit;

--insert into flight dim
DECLARE
    v_flight_id NUMBER;
    v_origin_airport_id NUMBER;
    v_destination_airport_id NUMBER;
    v_origin_date DATE;
    v_arrival_date DATE;
    v_origin_time TIMESTAMP;
    v_arrival_time TIMESTAMP;
    v_aircraft_id NUMBER;
    v_segment_miles NUMBER(10, 2);
    v_miles_earned NUMBER(10, 2);
    v_time_diff INTERVAL DAY TO SECOND;
    v_arrival_time_rounded TIMESTAMP;
    v_valid_time_id TIMESTAMP; -- To ensure a valid arrival time

BEGIN
    -- Get the next available flight_id
    SELECT NVL(MAX(flight_id), 0) + 1 INTO v_flight_id FROM flight_dim;

    FOR i IN 1..200 LOOP  -- Generate 200 flights
        -- Select random origin and destination airports
        SELECT airport_id INTO v_origin_airport_id
        FROM (SELECT airport_id FROM airport_dim ORDER BY DBMS_RANDOM.VALUE)
        WHERE ROWNUM = 1;

        SELECT airport_id INTO v_destination_airport_id
        FROM (SELECT airport_id FROM airport_dim WHERE airport_id <> v_origin_airport_id ORDER BY DBMS_RANDOM.VALUE)
        WHERE ROWNUM = 1;

        -- Select random origin date
        SELECT date_id INTO v_origin_date
        FROM (SELECT date_id FROM date_dim ORDER BY DBMS_RANDOM.VALUE)
        WHERE ROWNUM = 1;

        -- Select random arrival date within 2 days of origin date
        SELECT date_id INTO v_arrival_date
        FROM (SELECT date_id FROM date_dim WHERE date_id BETWEEN v_origin_date AND v_origin_date + 2 ORDER BY DBMS_RANDOM.VALUE)
        WHERE ROWNUM = 1;

        -- Select random origin time
        SELECT time_id INTO v_origin_time
        FROM (SELECT time_id FROM time_dim ORDER BY DBMS_RANDOM.VALUE)
        WHERE ROWNUM = 1;

        -- Calculate a random time difference for arrival time (between 1 and 12 hours)
        v_time_diff := NUMTODSINTERVAL(DBMS_RANDOM.VALUE(1, 12), 'HOUR');

        -- Calculate arrival time
        v_arrival_time := v_origin_time + v_time_diff;

        -- Round arrival time to the nearest 30-minute interval
        v_arrival_time_rounded := TO_TIMESTAMP(
            TO_CHAR(v_arrival_time, 'YYYY-MM-DD HH24:') ||
            CASE
                WHEN TO_NUMBER(TO_CHAR(v_arrival_time, 'MI')) < 30 THEN '00'
                ELSE '30'
            END || ':00',
            'YYYY-MM-DD HH24:MI:SS'
        );

        -- Ensure the rounded arrival time exists in the time_dim table
        BEGIN
            SELECT time_id INTO v_valid_time_id
            FROM time_dim
            WHERE time_id = v_arrival_time_rounded;

        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                -- If the rounded time doesn't exist, get the closest available time
                SELECT MIN(time_id) INTO v_valid_time_id
                FROM time_dim
                WHERE time_id > v_arrival_time_rounded;

                -- If still NULL, get the earliest available time in the table
                IF v_valid_time_id IS NULL THEN
                    SELECT MIN(time_id) INTO v_valid_time_id FROM time_dim;
                END IF;
        END;

        -- Ensure we have a valid arrival time before inserting
        IF v_valid_time_id IS NOT NULL THEN
            v_arrival_time := v_valid_time_id;
        ELSE
            -- Use a default fallback value (earliest time in time_dim)
            SELECT MIN(time_id) INTO v_arrival_time FROM time_dim;
        END IF;

        -- Select random aircraft
        SELECT aircraft_id INTO v_aircraft_id
        FROM (SELECT aircraft_id FROM aircraft_dim ORDER BY DBMS_RANDOM.VALUE)
        WHERE ROWNUM = 1;

        -- Generate random segment miles and miles earned
        v_segment_miles := ROUND(DBMS_RANDOM.VALUE(100, 5000), 2);
        v_miles_earned := ROUND(DBMS_RANDOM.VALUE(100, 5000), 2);

        -- Insert the flight
        INSERT INTO flight_dim (flight_id, origin_airport_id, destination_airport_id, origin_date, origin_time, arrival_date, arrival_time, aircraft_id, segment_miles, miles_earned)
        VALUES (v_flight_id, v_origin_airport_id, v_destination_airport_id, v_origin_date, v_origin_time, v_arrival_date, v_arrival_time, v_aircraft_id, v_segment_miles, v_miles_earned);

        -- Increment flight_id
        v_flight_id := v_flight_id + 1;
    END LOOP;
    COMMIT;
END;
/
COMMIT;
--segment activity fact data
INSERT ALL
    INTO SegmentActivityFact (passenger_id, class_services_id, promotion_id, flight_id, status_id, ticket_number, overnight_stay, revenue_amount, cancellation_fees, refund_amount,DATE_ID,TIME_ID) 
    VALUES (1, 1, 1, 101, 1, 'TKT10001', 0, 500.00, 0.00, 0.00, TO_DATE('2020-01-01', 'YYYY-MM-DD'), TO_TIMESTAMP('2020-01-01 00:00:00', 'YYYY-MM-DD HH24:MI:SS'))
    INTO SegmentActivityFact (passenger_id, class_services_id, promotion_id, flight_id, status_id, ticket_number, overnight_stay, revenue_amount, cancellation_fees, refund_amount,DATE_ID,TIME_ID) 
    VALUES (2, 2, NULL, 102, 2, 'TKT10002', 1, 750.00, 50.00, 100.00, TO_DATE('2020-01-02', 'YYYY-MM-DD'), TO_TIMESTAMP('2020-01-01 00:00:00', 'YYYY-MM-DD HH24:MI:SS'))
    INTO SegmentActivityFact (passenger_id, class_services_id, promotion_id, flight_id, status_id, ticket_number, overnight_stay, revenue_amount, cancellation_fees, refund_amount,DATE_ID,TIME_ID) 
    VALUES (3, 3, 2, 103, 3, 'TKT10003', 0, 1200.00, 80.00, 200.00, TO_DATE('2020-01-03', 'YYYY-MM-DD'), TO_TIMESTAMP('2020-01-01 00:00:00', 'YYYY-MM-DD HH24:MI:SS'))
    INTO SegmentActivityFact (passenger_id, class_services_id, promotion_id, flight_id, status_id, ticket_number, overnight_stay, revenue_amount, cancellation_fees, refund_amount,DATE_ID,TIME_ID)
    VALUES (4, 1, 3, 104, 1, 'TKT10004', 1, 400.00, 0.00, 0.00, TO_DATE('2020-01-04', 'YYYY-MM-DD'), TO_TIMESTAMP('2020-01-01 00:00:00', 'YYYY-MM-DD HH24:MI:SS')) 
    INTO SegmentActivityFact (passenger_id, class_services_id, promotion_id, flight_id, status_id, ticket_number, overnight_stay, revenue_amount, cancellation_fees, refund_amount,DATE_ID,TIME_ID) 
    VALUES (5, 2, NULL, 105, 2, 'TKT10005', 0, 600.00, 40.00, 90.00, TO_DATE('2020-01-05', 'YYYY-MM-DD'), TO_TIMESTAMP('2020-01-01 00:00:00', 'YYYY-MM-DD HH24:MI:SS'))
    INTO SegmentActivityFact (passenger_id, class_services_id, promotion_id, flight_id, status_id, ticket_number, overnight_stay, revenue_amount, cancellation_fees, refund_amount,DATE_ID,TIME_ID) 
    VALUES (6, 3, 4, 106, 3, 'TKT10006', 1, 1350.00, 100.00, 250.00, TO_DATE('2020-01-06', 'YYYY-MM-DD'), TO_TIMESTAMP('2020-01-01 00:00:00', 'YYYY-MM-DD HH24:MI:SS'))
    INTO SegmentActivityFact (passenger_id, class_services_id, promotion_id, flight_id, status_id, ticket_number, overnight_stay, revenue_amount, cancellation_fees, refund_amount,DATE_ID,TIME_ID) 
    VALUES (7, 1, NULL, 107, 1, 'TKT10007', 0, 520.00, 0.00, 0.00, TO_DATE('2020-01-07', 'YYYY-MM-DD'), TO_TIMESTAMP('2020-01-01 02:30:00', 'YYYY-MM-DD HH24:MI:SS'))
    INTO SegmentActivityFact (passenger_id, class_services_id, promotion_id, flight_id, status_id, ticket_number, overnight_stay, revenue_amount, cancellation_fees, refund_amount,DATE_ID,TIME_ID) 
    VALUES (8, 2, 2, 108, 2, 'TKT10008', 1, 820.00, 60.00, 120.00, TO_DATE('2020-01-08', 'YYYY-MM-DD'), TO_TIMESTAMP('2020-01-01 02:30:00', 'YYYY-MM-DD HH24:MI:SS'))
    INTO SegmentActivityFact (passenger_id, class_services_id, promotion_id, flight_id, status_id, ticket_number, overnight_stay, revenue_amount, cancellation_fees, refund_amount,DATE_ID,TIME_ID) 
    VALUES (9, 3, NULL, 109, 3, 'TKT10009', 0, 1450.00, 120.00, 300.00, TO_DATE('2020-01-09', 'YYYY-MM-DD'), TO_TIMESTAMP('2020-01-01 02:30:00', 'YYYY-MM-DD HH24:MI:SS'))
    INTO SegmentActivityFact (passenger_id, class_services_id, promotion_id, flight_id, status_id, ticket_number, overnight_stay, revenue_amount, cancellation_fees, refund_amount,DATE_ID,TIME_ID) 
    VALUES (10, 1, 1, 110, 1, 'TKT10010', 1, 550.00, 0.00, 0.00, TO_DATE('2020-01-10', 'YYYY-MM-DD'), TO_TIMESTAMP('2020-01-01 02:30:00', 'YYYY-MM-DD HH24:MI:SS'))
SELECT 1 FROM DUAL;

Commit;

