-- CHECK example
-- The CHECK constraint is used to limit the value range that can be placed in a column.
-- If a value outside the specified range is attempted to be inserted,
-- the database will reject the operation and raise an error.
CREATE TABLE products (
    id serial PRIMARY KEY,
    name varchar(100) NOT NULL,
    price numeric CHECK (price > 0),
    stock integer CHECK (stock >= 0)
);

INSERT INTO
    products (name, price, stock)
VALUES
    ('Laptop', 999.99, 10),
    ('Smartphone', 499.99, 25),
    ('Tablet', 299.99, 15);

-- Attempting to insert invalid values will result in an error
-- Uncommenting the following lines will cause a CHECK constraint violation
-- INSERT INTO
--     products (name, price, stock)
-- VALUES
--     ('Invalid Product', -100, 5),  -- Invalid price
--     ('Another Invalid Product', 100, -10);  -- Invalid stock