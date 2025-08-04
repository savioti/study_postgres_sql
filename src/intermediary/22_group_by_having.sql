-- setup query
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
    ('Tokyo', 'Japan', 38505000, 8223),
    ('New York', 'USA', 8419600, 789),
    ('Los Angeles', 'USA', 3980400, 1302),
    ('São Paulo', 'Brazil', 20935000, 3043),
    ('Belo Horizonte', 'Brazil', 2500000, 331),
    ('Rio de Janeiro', 'Brazil', 6748000, 1182);

-- GROUP BY with HAVING example
SELECT
    country,
    population
FROM
    cities
GROUP BY
    country,
    population
HAVING
    population > 20000000;

-- GROUP BY with HAVING example with aggregate function
SELECT
    country
FROM
    cities
GROUP BY
    country
HAVING
    COUNT(*) > 1;