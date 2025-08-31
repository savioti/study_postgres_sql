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

-- Using the SUBSTRING function to extract a part of a string
SELECT
    name,
    SUBSTRING(
        name
        FROM
            1 FOR 3
    ) AS city_name_abbreviation,
    SUBSTRING(
        country
        FROM
            1 FOR 3
    ) AS country_abbreviation
FROM
    cities;

-- Using the TRIM function to remove leading and trailing spaces
SELECT
    name,
    TRIM(name) AS trimmed_name,
    country,
    TRIM(country) AS trimmed_country
FROM
    cities;

-- Using the REPLACE function to replace occurrences of a substring
SELECT
    name,
    REPLACE(name, 'a', '@') AS replaced_name,
    country,
    REPLACE(country, 'a', '@') AS replaced_country
FROM
    cities;