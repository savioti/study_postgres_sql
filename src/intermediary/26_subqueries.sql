CREATE TABLE phones (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    manufacturer VARCHAR(50) NOT NULL,
    price INTEGER NOT NULL,
    units_sold INTEGER NOT NULL
);

INSERT INTO
    phones (name, manufacturer, price, units_sold)
VALUES
    ('N1280', 'Nokia', 199, 1925),
    ('Iphone 4', 'Apple', 399, 9436),
    ('Galaxy S', 'Samsung', 299, 2359),
    ('S5620 Monte', 'Samsung', 250, 2385),
    ('N8', 'Nokia', 150, 7543),
    ('Droid', 'Motorola', 150, 8395),
    ('Wave S8500', 'Samsung', 175, 9259);

-- Embedding in Select
-- Write a query that prints the name and price for each phone.
-- In addition, print out the ratio of the phones price against
-- max price of all phones (so price / max price).  Rename this
-- third column to price_ratio
SELECT
    name,
    price,
    price / (
        SELECT
            max(price)
        FROM
            phones
    ) AS price_ratio
FROM
    phones;

-- Subquery From's
-- Calculate the average price of phones for each manufacturer.
-- Then print the highest average price.
-- Rename this value to max_average_price
SELECT
    max(p.avg_price) AS max_average_price
FROM
    (
        SELECT
            manufacturer,
            avg(price) AS avg_price
        FROM
            phones
        GROUP BY
            manufacturer
    ) AS p;

-- Subquery Joins
-- Find the manufacturer with the highest total units sold.
-- Print the manufacturer and the total units sold.
SELECT
    p.manufacturer,
    SUM(p.units_sold) AS total_units_sold
FROM
    phones AS p
    JOIN (
        SELECT
            manufacturer,
            SUM(units_sold) AS total_units_sold
        FROM
            phones
        GROUP BY
            manufacturer
        ORDER BY
            total_units_sold DESC
        LIMIT
            1
    ) AS top_manufacturer ON p.manufacturer = top_manufacturer.manufacturer
GROUP BY
    p.manufacturer;

-- Subquery Where's
-- Write a query that prints out the name and price
-- of phones that have a price greater than the Samsung S5620 Monte.
SELECT
    name,
    price
FROM
    phones
WHERE
    price > (
        SELECT
            price
        FROM
            phones
        WHERE
            name = 'S5620 Monte'
    );

-- From-less Selects
-- Using only subqueries, print the max price, min price, and average price of all phones.
-- Rename each column to max_price, min_price, avg_price
SELECT
    (
        SELECT
            max(price)
        FROM
            phones
    ) AS max_price,
    (
        SELECT
            min(price)
        FROM
            phones
    ) AS min_price,
    (
        SELECT
            avg(price)
        FROM
            phones
    ) AS avg_price;