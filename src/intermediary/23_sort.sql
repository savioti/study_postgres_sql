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

-- SORT example
SELECT
    *
FROM
    cities
ORDER BY
    population;

-- output:
-- id	name	            country	    population	area
-- 7	Belo Horizonte	    Brazil	    2500000	    331
-- 5	Los Angeles	        USA	        3980400	    1302
-- 6	Rio de Janeiro	    Brazil	    6748000	    1182
-- 4	New York	        USA	        8419600	    789
-- 8	São Paulo	        Brazil	    20935000	3043
-- 2	Shanghai	        China	    22125000	4015
-- 1	Delhi	            India	    28125000	2240
-- 3	Tokyo	            Japan	    38505000	8223
-- SORT example with DESC
SELECT
    *
FROM
    cities
ORDER BY
    area DESC;

-- output:
-- id	name	            country	    population	area
-- 3	Tokyo	            Japan	    38505000	8223
-- 2	Shanghai	        China	    22125000	4015
-- 8	São Paulo	        Brazil	    20935000	3043
-- 1	Delhi	            India	    28125000	2240
-- 5	Los Angeles	        USA	        3980400	    1302
-- 6	Rio de Janeiro	    Brazil	    6748000	    1182
-- 4	New York	        USA	        8419600	    789
-- 7	Belo Horizonte	    Brazil	    2500000	    331
-- SORT example with string sorting
SELECT
    *
FROM
    cities
ORDER BY
    name;

-- output:
-- id	name	            country	    population	area
-- 7	Belo Horizonte	    Brazil	    2500000	    331
-- 1	Delhi	            India	    28125000	2240
-- 5	Los Angeles	        USA	        3980400	    1302
-- 4	New York	        USA	        8419600	    789
-- 6	Rio de Janeiro	    Brazil	    6748000	    1182
-- 2	Shanghai	        China	    22125000	4015
-- 8	São Paulo	        Brazil	    20935000	3043
-- 3	Tokyo	            Japan	    38505000	8223