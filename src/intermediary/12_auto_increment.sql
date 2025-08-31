CREATE TABLE users (
    -- serial works as an auto-incrementing integer only in PostgreSQL
    id serial PRIMARY KEY,
    username varchar(50)
);

INSERT INTO
    users (username)
VALUES
    ('John Doe'),
    ('Jane Smith'),
    ('Alice Johnson'),
    ('Bob Brown');

SELECT
    *
FROM
    users;