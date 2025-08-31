-- UNIQUE constraint example
-- The UNIQUE constraint ensures that all values in a column
-- are distinct from one another. This is crucial for maintaining
-- data integrity, as it prevents duplicate entries in fields
-- that require unique values, such as email addresses or usernames.
CREATE TABLE users (
    id serial PRIMARY KEY,
    username varchar(50) UNIQUE,
    email varchar(100) UNIQUE
);

INSERT INTO
    users (username, email)
VALUES
    ('johndoe', 'johndoe@email'),
    ('janesmith', 'janesmith@email'),
    ('alicej', 'alicej@email');

-- Attempting to insert duplicate values will result in an error
-- Uncommenting the following lines will cause a UNIQUE constraint violation
-- INSERT INTO
--     users (username, email)
-- VALUES
--     ('johndoe', 'johndoe2@email'),  -- Duplicate username
--     ('bobbrown', 'alicej@email');   -- Duplicate email