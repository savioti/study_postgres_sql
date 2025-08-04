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

--GROUP BY example
SELECT
    country,
    COUNT(*) AS total_cities,
    AVG(population) AS average_population,
    SUM(area) AS total_area
FROM
    cities
GROUP BY
    country;

-- output:
-- country	total_cities	average_population	    total_area
-- China	1	            22125000.000000000000	4015
-- USA	    2	             6200000.000000000000	2091
-- India	1	            28125000.000000000000	2240
-- Japan	1	            38505000.000000000000	8223
-- Brazil	3	            10061000.000000000000	4556