CREATE TABLE cities (
    id SERIAL PRIMARY KEY,
    name varchar(50),
    country varchar(50),
    population integer,
    area integer
);

INSERT INTO
    cities (name, country, population, area)
VALUES
    ('Delhi', 'India', 28125000, 2240),
    ('Shanghai', 'China', 22125000, 4015),
    ('São Paulo', 'Brazil', 20935000, 3043);

-- COUNT() example
SELECT
    COUNT(*) AS total_cities
FROM
    cities;

-- output: total_cities
-- 3
-- AVG() example
SELECT
    AVG(population) AS average_population
FROM
    cities;

-- output: average_population
-- 23728333.333333333333
-- SUM() example
SELECT
    SUM(area) AS total_area
FROM
    cities;

-- output: total_area
-- 9298
-- MAX() example
SELECT
    MAX(population) AS largest_population
FROM
    cities;

-- output: largest_population
-- 28125000
-- MIN() example
SELECT
    MIN(area) AS smallest_area
FROM
    cities;

-- output: smallest_area
-- 2240