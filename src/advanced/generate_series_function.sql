-- generate_series() function example
SELECT
    generate_series(1, 10) AS number;

-- insert generated series into a table
CREATE TABLE numbers (
    id SERIAL PRIMARY KEY,
    value integer
);

INSERT INTO
    numbers (value)
SELECT
    generate_series(1, 100);