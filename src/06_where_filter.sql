-- 13. Filtering Rows with "Where"
-- This query selects the names and areas of cities where the area is greater than 4000 square kilometers.
SELECT
    name,
    area
FROM
    cities
WHERE
    area > 4000;

-- 14. More on the "Where" Keyword
-- = operator
SELECT
    name,
    country
FROM
    cities
WHERE
    name = 'Tokyo';

-- != operator
SELECT
    name,
    country
FROM
    cities
WHERE
    name != 'Tokyo';

-- < operator
SELECT
    name,
    population
FROM
    cities
WHERE
    population < 25000000;

-- <= operator
SELECT
    name,
    population
FROM
    cities
WHERE
    population <= 22125000;

-- > operator
SELECT
    name,
    population
FROM
    cities
WHERE
    population > 25000000;

-- >= operator
SELECT
    name,
    population
FROM
    cities
WHERE
    population >= 28125000;

-- BETWEEN operator
SELECT
    name,
    population
FROM
    cities
WHERE
    population BETWEEN 25000000
    AND 30000000;

-- NOT BETWEEN operator
SELECT
    name,
    population
FROM
    cities
WHERE
    population NOT BETWEEN 25000000
    AND 30000000;

-- IN operator
SELECT
    name,
    country
FROM
    cities
WHERE
    country IN ('Japan', 'India', 'China');

-- NOT IN operator
SELECT
    name,
    country
FROM
    cities
WHERE
    country NOT IN ('Japan', 'India', 'China');

-- <> operator
SELECT
    name,
    country
FROM
    cities
WHERE
    country <> 'Japan';

-- 15. Compound "Where" Clauses
-- compound conditions with AND
SELECT
    name,
    population,
    area
FROM
    cities
WHERE
    population > 20000000
    AND area < 4000
    AND country IN ('Japan', 'India', 'China');

-- compound conditions with OR
SELECT
    name,
    population,
    area
FROM
    cities
WHERE
    population < 30000000
    OR country NOT IN ('Japan', 'India', 'China');

-- 20. Calculations in "Where" Clauses
SELECT
    name,
    population / area AS population_density
FROM
    cities
WHERE
    population / area > 6000;