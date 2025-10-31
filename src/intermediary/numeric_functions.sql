CREATE TABLE products_test (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50),
    price NUMERIC(10, 2),
    weight NUMERIC(6, 2),
    discount NUMERIC(5, 2)
);

INSERT INTO
    products_test (name, price, weight, discount)
VALUES
    ('Laptop', 3500.75, 2.20, 150.50),
    ('Smartphone', -1800.33, 0.18, 0.00),
    ('Tablet', 1200.99, 0.40, 100.00),
    ('Monitor', 900.00, 3.50, -50.00),
    ('Keyboard', 120.49, 0.60, 10.00),
    ('Mouse', -80.00, 0.10, 5.00),
    ('Printer', 650.25, 6.00, 0.00),
    ('Gaming Chair', 1100.00, 15.00, 200.00),
    ('Headset', 250.99, 0.35, 25.00),
    ('Webcam', 200.00, 0.09, 0.00),
    ('External Hard Drive', 400.00, 0.25, 40.00),
    ('Flash Drive', 60.00, 0.02, 0.00);

-- id	name	        price	    weight	discount
-- 1	Laptop	        3500.75	    2.20	150.50
-- 2	Smartphone	    -1800.33	0.18	0.00
-- 3	Tablet	        1200.99	    0.40	100.00
-- 4	Monitor	        900.00	    3.50	-50.00
-- 5	Keyboard	    120.49	    0.60	10.00
-- 6	Mouse	        -80.00	    0.10	5.00
-- 7	Printer	        650.25	    6.00	0.00
-- 8	Gaming Chair	1100.00	    15.00	200.00
-- 9	Headset	        250.99	    0.35	25.00
-- 10	Webcam	        200.00	    0.09	0.00
-- 11	External HD	    400.00	    0.25	40.00
-- 12	Flash Drive	    60.00	    0.02	0.00
-- ABS function
-- Show the name and absolute value of the price of each product
SELECT
    name,
    ABS(price) AS absolute_price
FROM
    products_test;

-- CEIL function
-- Show the name and the ceiling value of the weight of each product
SELECT
    name,
    CEILING(weight) AS ceiling_weight
FROM
    products_test;

-- FLOOR function
-- Show the name and the floor value of the weight of each product
SELECT
    name,
    FLOOR(weight) AS floor_weight
FROM
    products_test;

-- ROUND function
-- Show the name and the weight of each product rounded to the nearest integer
SELECT
    name,
    ROUND(weight) AS rounded_weight
FROM
    products_test;

-- MOD function
-- Show the name and whether the name length is even or odd
-- If even print "even" else print "odd"
SELECT
    name,
    CASE
        WHEN MOD(LENGTH(name), 2) = 0 THEN 'even'
        ELSE 'odd'
    END AS name_length_type
FROM
    products_test;