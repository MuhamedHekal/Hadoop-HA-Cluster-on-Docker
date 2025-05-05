-- 1. Aircraft table (source for aircraft_dim)
CREATE TABLE aircraft (
    aircraft_id NUMBER PRIMARY KEY,
    model VARCHAR2(50) NOT NULL,
    name VARCHAR2(50) NOT NULL,
    manufacturer VARCHAR2(100) NOT NULL,
    manufacture_date DATE,
    total_seats NUMBER NOT NULL,
    status VARCHAR2(20) CHECK (status IN ('Active', 'Maintenance', 'Retired')),
    created_at TIMESTAMP DEFAULT SYSTIMESTAMP NOT NULL,
    updated_at TIMESTAMP DEFAULT SYSTIMESTAMP NOT NULL
);

-- 2. Airport table (source for airport_dim)
CREATE TABLE airport (
    airport_id NUMBER PRIMARY KEY,
    iata_code VARCHAR2(3) UNIQUE NOT NULL,
    airport_name VARCHAR2(100) NOT NULL,
    city VARCHAR2(100) NOT NULL,
    country VARCHAR2(100) NOT NULL,
    latitude NUMBER,
    longitude NUMBER,
    timezone VARCHAR2(50),
    created_at TIMESTAMP DEFAULT SYSTIMESTAMP NOT NULL,
    updated_at TIMESTAMP DEFAULT SYSTIMESTAMP NOT NULL
);

-- 3. Passenger table (source for customer_dim)
CREATE TABLE passenger (
    passenger_id NUMBER PRIMARY KEY,
    first_name VARCHAR2(50) NOT NULL,
    last_name VARCHAR2(50) NOT NULL,
    date_of_birth DATE,
    gender VARCHAR2(10),
    phone VARCHAR2(20),
    address VARCHAR2(200),
    city VARCHAR2(100),
    country VARCHAR2(100),
    passport_number VARCHAR2(50),
    passport_expiry DATE,
    frequent_flyer_points NUMBER DEFAULT 0,
    membership_tier VARCHAR2(20) DEFAULT 'Standard',
    registration_date DATE,
    created_at TIMESTAMP DEFAULT SYSTIMESTAMP NOT NULL,
    updated_at TIMESTAMP DEFAULT SYSTIMESTAMP NOT NULL
);

-- 4. Flight Schedule table
CREATE TABLE flight_schedule (
    schedule_id NUMBER PRIMARY KEY,
    flight_number VARCHAR2(10) NOT NULL,
    origin_airport_id NUMBER NOT NULL,
    destination_airport_id NUMBER NOT NULL,
    departure_time_local TIMESTAMP NOT NULL,
    arrival_time_local TIMESTAMP NOT NULL,
    duration_minutes NUMBER,
    operating_days VARCHAR2(7),
    effective_from DATE NOT NULL,
    effective_to DATE NOT NULL,
    aircraft_type_id NUMBER NOT NULL,
    created_at TIMESTAMP DEFAULT SYSTIMESTAMP NOT NULL,
    updated_at TIMESTAMP DEFAULT SYSTIMESTAMP NOT NULL,
    CONSTRAINT fk_schedule_origin FOREIGN KEY (origin_airport_id) REFERENCES airport(airport_id),
    CONSTRAINT fk_schedule_dest FOREIGN KEY (destination_airport_id) REFERENCES airport(airport_id),
    CONSTRAINT fk_schedule_aircraft FOREIGN KEY (aircraft_type_id) REFERENCES aircraft(aircraft_id)
);

-- 5. Actual Flight table (source for flight_dim)
CREATE TABLE flight (
    flight_id NUMBER PRIMARY KEY,
    schedule_id NUMBER NOT NULL,
    actual_departure TIMESTAMP,
    actual_arrival TIMESTAMP,
    aircraft_id NUMBER NOT NULL,
    departure_gate VARCHAR2(10),
    arrival_gate VARCHAR2(10),
    status VARCHAR2(20) CHECK (status IN ('Scheduled', 'Boarding', 'Departed', 'Arrived', 'Delayed', 'Cancelled')),
    first_officer_id NUMBER,
    flight_attendant_lead_id NUMBER,
    created_at TIMESTAMP DEFAULT SYSTIMESTAMP NOT NULL,
    updated_at TIMESTAMP DEFAULT SYSTIMESTAMP NOT NULL,
    CONSTRAINT fk_flight_schedule FOREIGN KEY (schedule_id) REFERENCES flight_schedule(schedule_id),
    CONSTRAINT fk_flight_aircraft FOREIGN KEY (aircraft_id) REFERENCES aircraft(aircraft_id)
);

-- 6. Class Services table (source for class_services_dim)
CREATE TABLE class_services (
    class_service_id NUMBER PRIMARY KEY,
    class_purchased VARCHAR2(50) NOT NULL,
    class_flown VARCHAR2(50),
    class_change_indicator VARCHAR2(20),
    meal_options VARCHAR2(100),
    baggage_allowance VARCHAR2(100),
    created_at TIMESTAMP DEFAULT SYSTIMESTAMP NOT NULL,
    updated_at TIMESTAMP DEFAULT SYSTIMESTAMP NOT NULL
);

-- 7. Promotion table (source for promotion_dim)
CREATE TABLE promotion (
    promotion_id NUMBER PRIMARY KEY,
    promotion_code VARCHAR2(20) UNIQUE NOT NULL,
    description VARCHAR2(200) NOT NULL,
    discount_percentage NUMBER(5,2),
    max_discount_amount NUMBER(10,2),
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    category VARCHAR2(50) CHECK (category IN ('Seasonal', 'Loyalty', 'Corporate', 'Special Event')),
    created_at TIMESTAMP DEFAULT SYSTIMESTAMP NOT NULL,
    updated_at TIMESTAMP DEFAULT SYSTIMESTAMP NOT NULL
);

-- 8. Booking table (connects passengers to flights)
CREATE TABLE booking (
    booking_id NUMBER PRIMARY KEY,
    passenger_id NUMBER NOT NULL,
    booking_date TIMESTAMP NOT NULL,
    total_amount NUMBER(10,2) NOT NULL,
    payment_status VARCHAR2(20) DEFAULT 'Pending' CHECK (payment_status IN ('Pending', 'Paid', 'Refunded')),
    payment_method VARCHAR2(50),
    promotion_id NUMBER,
    created_at TIMESTAMP DEFAULT SYSTIMESTAMP NOT NULL,
    updated_at TIMESTAMP DEFAULT SYSTIMESTAMP NOT NULL,
    CONSTRAINT fk_booking_passenger FOREIGN KEY (passenger_id) REFERENCES passenger(passenger_id),
    CONSTRAINT fk_booking_promotion FOREIGN KEY (promotion_id) REFERENCES promotion(promotion_id)
);

-- 9. Trip Status table (source for trip_status_dim)
CREATE TABLE trip_status (
    status_id NUMBER PRIMARY KEY,
    reservation_status VARCHAR2(50) NOT NULL,
    cancellation_reason VARCHAR2(100),
    is_active CHAR(1) DEFAULT 'Y' CHECK (is_active IN ('Y', 'N')),
    created_at TIMESTAMP DEFAULT SYSTIMESTAMP NOT NULL,
    updated_at TIMESTAMP DEFAULT SYSTIMESTAMP NOT NULL
);

-- 10. Flight status log
CREATE TABLE flight_status_log (
    log_id NUMBER PRIMARY KEY,
    flight_id NUMBER NOT NULL,
    status_id NUMBER NOT NULL,
    status_time TIMESTAMP NOT NULL,
    remarks VARCHAR2(200),
    created_at TIMESTAMP DEFAULT SYSTIMESTAMP NOT NULL,
    updated_at TIMESTAMP DEFAULT SYSTIMESTAMP NOT NULL,
    CONSTRAINT fk_statuslog_flight FOREIGN KEY (flight_id) REFERENCES flight(flight_id),
    CONSTRAINT fk_statuslog_status FOREIGN KEY (status_id) REFERENCES trip_status(status_id)
);

-- 11. Ticket table (source for SegmentActivityFact)
CREATE TABLE ticket (
    ticket_id NUMBER PRIMARY KEY,
    ticket_number VARCHAR2(20) UNIQUE NOT NULL,
    booking_id NUMBER NOT NULL,
    flight_id NUMBER NOT NULL,
    passenger_id NUMBER NOT NULL,
    seat_number VARCHAR2(10),
    class_service_id NUMBER NOT NULL,
    fare_amount NUMBER(10,2) NOT NULL,
    taxes_and_fees NUMBER(10,2),
    status_id NUMBER NOT NULL,
    cancellation_date TIMESTAMP,
    cancellation_reason VARCHAR2(100),
    refund_amount NUMBER(10,2),
    miles_earned NUMBER(10,2),
    created_at TIMESTAMP DEFAULT SYSTIMESTAMP NOT NULL,
    updated_at TIMESTAMP DEFAULT SYSTIMESTAMP NOT NULL,
    CONSTRAINT fk_ticket_booking FOREIGN KEY (booking_id) REFERENCES booking(booking_id),
    CONSTRAINT fk_ticket_flight FOREIGN KEY (flight_id) REFERENCES flight(flight_id),
    CONSTRAINT fk_ticket_passenger FOREIGN KEY (passenger_id) REFERENCES passenger(passenger_id),
    CONSTRAINT fk_ticket_class_service FOREIGN KEY (class_service_id) REFERENCES class_services(class_service_id),
    CONSTRAINT fk_ticket_status FOREIGN KEY (status_id) REFERENCES trip_status(status_id)
);

-- 12. Seat Assignment table
CREATE TABLE seat_assignment (
    assignment_id NUMBER PRIMARY KEY,
    ticket_id NUMBER NOT NULL,
    seat_number VARCHAR2(10) NOT NULL,
    assignment_date TIMESTAMP NOT NULL,
    created_at TIMESTAMP DEFAULT SYSTIMESTAMP NOT NULL,
    updated_at TIMESTAMP DEFAULT SYSTIMESTAMP NOT NULL,
    CONSTRAINT fk_assignment_ticket FOREIGN KEY (ticket_id) REFERENCES ticket(ticket_id)
);

-- 13. Flight Mileage table (for segment_miles and miles_earned)
CREATE TABLE flight_mileage (
    mileage_id NUMBER PRIMARY KEY,
    origin_airport_id NUMBER NOT NULL,
    destination_airport_id NUMBER NOT NULL,
    distance_miles NUMBER(10,2) NOT NULL,
    effective_date DATE NOT NULL,
    created_at TIMESTAMP DEFAULT SYSTIMESTAMP NOT NULL,
    updated_at TIMESTAMP DEFAULT SYSTIMESTAMP NOT NULL,
    CONSTRAINT fk_mileage_origin FOREIGN KEY (origin_airport_id) REFERENCES airport(airport_id),
    CONSTRAINT fk_mileage_dest FOREIGN KEY (destination_airport_id) REFERENCES airport(airport_id)
);

-- 14. Overnight Stay table (for overnight_stay in fact)
CREATE TABLE overnight_stay (
    stay_id NUMBER PRIMARY KEY,
    ticket_id NUMBER NOT NULL,
    stay_date DATE NOT NULL,
    hotel_name VARCHAR2(100),
    city VARCHAR2(100),
    created_at TIMESTAMP DEFAULT SYSTIMESTAMP NOT NULL,
    updated_at TIMESTAMP DEFAULT SYSTIMESTAMP NOT NULL,
    CONSTRAINT fk_stay_ticket FOREIGN KEY (ticket_id) REFERENCES ticket(ticket_id)
);