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
    (20, 'Jacket', 'Clothing', 350, 3);

-- GREATEST function
-- Compute the cost to ship each item
-- Shipping cost is greatest value between (weight * $2) or $30
SELECT
    name,
    weight,
    GREATEST(30, 2 * weight) AS shipping_cost
FROM
    products;

-- LEAST function
-- Find the sale price of each product.
-- Price is the least of the products price * 0.5 or $400
SELECT
    name,
    price AS original_price,
    LEAST(price * 0.5, 400) AS sale_price
FROM
    products;

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