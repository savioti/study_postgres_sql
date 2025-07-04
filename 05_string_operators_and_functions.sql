-- || operator concatenation example
SELECT
    name || ', ' || country AS location
FROM
    cities;

-- Using the CONCAT function
SELECT
    CONCAT(name, ', ', country) AS location
FROM
    cities;

-- Using the LOWER function to convert text to lowercase
SELECT
    LOWER(name) AS lower_name,
    LOWER(country) AS lower_country
FROM
    cities;

-- Using the UPPER function to convert text to uppercase
SELECT
    UPPER(name) AS upper_name,
    UPPER(country) AS upper_country
FROM
    cities;

-- Combining CONCAT, LOWER and UPPER functions
SELECT
    CONCAT(LOWER(name), ', ', UPPER(country)) AS formatted_location
FROM
    cities;

-- Using the LENGTH function to get the length of a string
SELECT
    name,
    LENGTH(name) AS name_length,
    LENGTH(country) AS country_length
FROM
    cities;