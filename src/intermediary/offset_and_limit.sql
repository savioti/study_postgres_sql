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

-- LIMIT example: 5 cities with the smallest population
SELECT
    *
FROM
    cities
ORDER BY
    population
LIMIT
    5;

-- output:
-- id	name	            country	    population	area
-- 7	Belo Horizonte	    Brazil	    2500000	    331
-- 5	Los Angeles	        USA	        3980400	    1302
-- 6	Rio de Janeiro	    Brazil	    6748000	    1182
-- 4	New York	        USA	        8419600	    789
-- 8	São Paulo	        Brazil	    20935000	3043
--
-- OFFSET example show the second page of smallest population results
SELECT
    *
FROM
    cities
ORDER BY
    population
LIMIT
    5 OFFSET 5;

-- output:
-- id	name	    country	population	area
-- 2	Shanghai	China	22125000	4015
-- 1	Delhi	    India	28125000	2240
-- 3	Tokyo	    Japan	38505000	8223