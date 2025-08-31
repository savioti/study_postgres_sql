CREATE TABLE products (
    id INT PRIMARY KEY,
    name VARCHAR(50),
    department VARCHAR(50),
    price INT,
    weight INT
);

INSERT INTO
    products (id, name, department, price, weight)
VALUES
    (1, 'Gloves', 'Sports', 55, 1),
    (2, 'Drill', 'Tools', 350, 5),
    (3, 'Sneakers', 'Clothing', 220, 2),
    (4, 'Desk', 'Furniture', 800, 20),
    (5, 'Watch', 'Accessories', 1200, 1),
    (6, 'Blender', 'Kitchen', 400, 4),
    (7, 'Helmet', 'Sports', 180, 2),
    (8, 'Curtains', 'Home', 250, 3),
    (9, 'Socks', 'Clothing', 30, 1),
    (10, 'Camera', 'Electronics', 1500, 2),
    (11, 'Fan', 'Home', 350, 5),
    (12, 'Toaster', 'Kitchen', 180, 2),
    (13, 'Earrings', 'Accessories', 90, 1),
    (14, 'Hammer', 'Tools', 75, 2),
    (15, 'Yoga Mat', 'Sports', 120, 1),
    (16, 'Sunglasses', 'Accessories', 250, 1),
    (17, 'Pillow', 'Furniture', 60, 2),
    (18, 'Mixer', 'Kitchen', 700, 6),
    (19, 'Tablet', 'Electronics', 1100, 1),
    (20, 'Jacket', 'Clothing', 350, 3),
    (21, 'PostalCard', 'Accessories', 10, 0),
    (22, 'Sticker', 'Accessories', 5, 0);

-- CASE keyword
-- Print each product and its price. Also print a description of the price.
-- If price > 600 then "high" if price > 300 then "medium" else print "cheap"
SELECT
    name,
    price,
    CASE
        WHEN price > 600 THEN 'high'
        WHEN price > 300 THEN 'medium'
        ELSE 'cheap'
    END
FROM
    products;

-- NULLIF function
-- Print each product, its price and its weight.
-- If the product weight is 0, print NULL for the weight instead.
SELECT
    name,
    price,
    NULLIF(weight, 0) AS normalized_weight
FROM
    products;

-- COALESCE function
-- Print each product, its price and its weight.
-- If the product weight is 0, print 1 for the weight instead.
SELECT
    name,
    price,
    COALESCE(NULLIF(weight, 0), 1) AS normalized_weight
FROM
    products;