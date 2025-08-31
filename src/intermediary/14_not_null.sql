-- NOT NULL example
-- The NOT NULL constraint is used to ensure that a column
-- cannot have a NULL value. This is important for maintaining
-- data integrity, as it ensures that certain fields always
-- contain valid data.
CREATE TABLE employees (
    id serial PRIMARY KEY,
    name varchar(100) NOT NULL,
    manager_id integer REFERENCES employees(id)
);

INSERT INTO
    employees (name, manager_id)
VALUES
    ('Alice', NULL),
    ('Bob', 1),
    ('Charlie', 1),
    ('David', 2);

SELECT
    *
FROM
    employees;