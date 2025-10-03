-- setup
CREATE TABLE products(
    id SERIAL PRIMARY KEY,
    name VARCHAR(50),
    price INTEGER,
    stock INTEGER,
    category_id INTEGER REFERENCES category(id) ON DELETE CASCADE
);

CREATE TABLE category(
    id SERIAL PRIMARY KEY,
    name VARCHAR(50),
    is_discontinued BOOLEAN DEFAULT FALSE
);

INSERT INTO
    category (name, is_discontinued)
VALUES
    ('Electronics', FALSE),
    ('Clothing', FALSE),
    ('Books', FALSE),
    ('Home & Kitchen', FALSE);

INSERT INTO
    products (name, price, stock, category_id)
VALUES
    ('Laptop', 1000, 50, 1),
    ('Smartphone', 700, 150, 1),
    ('Jeans', 40, 200, 2),
    ('T-Shirt', 20, 300, 2),
    ('Novel', 15, 5, 3),
    ('Cookbook', 25, 8, 3),
    ('Blender', 60, 80, 4),
    ('Toaster', 30, 120, 4);

-- update categories to discontinued if all products in that category have stock less than 10
UPDATE
    category
SET
    is_discontinued = TRUE
FROM
    products
WHERE
    category.id = products.category_id
    AND products.stock < 10;