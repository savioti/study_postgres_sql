-- setup
CREATE TABLE hotel_bookings (
    id SERIAL PRIMARY KEY,
    guest_name VARCHAR(50),
    checkin_date DATE,
    checkin_time TIME,
    checkout_timestamp TIMESTAMP,
    room_price NUMERIC(8, 2)
);

INSERT INTO
    hotel_bookings (
        guest_name,
        checkin_date,
        checkin_time,
        checkout_timestamp,
        room_price
    )
VALUES
    (
        'Alice',
        '2025-09-20',
        '14:00',
        '2025-09-22 11:00:00',
        350.00
    ),
    (
        'Bob',
        '2025-09-21',
        '16:30',
        '2025-09-23 10:00:00',
        420.00
    ),
    (
        'Charlie',
        '2025-09-22',
        '12:00',
        '2025-09-25 09:30:00',
        600.00
    ),
    (
        'Diana',
        '2025-09-23',
        '15:00',
        '2025-09-24 12:00:00',
        280.00
    );

-- INTERVAL examples
SELECT
    guest_name,
    checkin_date,
    checkin_date + INTERVAL '2 days' AS suggested_checkout
FROM
    hotel_bookings;

-- TIMESTAMP to DATE conversion and date difference
SELECT
    guest_name,
    checkout_timestamp :: date - checkin_date AS nights
FROM
    hotel_bookings;

-- TIME addition example
SELECT
    guest_name,
    checkin_time,
    checkin_time + INTERVAL '3 hours' AS late_checkin
FROM
    hotel_bookings;

-- date_part() function examples
SELECT
    guest_name,
    date_part('year', checkin_date) AS checkin_year,
    date_part('month', checkin_date) AS checkin_month,
    date_part('day', checkin_date) AS checkin_day,
    date_part('hour', checkin_time) AS checkin_hour
FROM
    hotel_bookings;

-- date_trunc() function examples
SELECT
    guest_name,
    checkin_date,
    date_trunc('month', checkin_date) AS month_start,
    date_trunc('year', checkin_date) AS year_start
FROM
    hotel_bookings;