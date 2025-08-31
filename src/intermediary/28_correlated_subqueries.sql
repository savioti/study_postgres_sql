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

-- correlated subquery
-- Show the name, department and price of the most expensive
-- product in each department
SELECT
    name,
    department,
    price
FROM
    products p1
WHERE
    p1.price = (
        SELECT
            max(p2.price)
        FROM
            products p2
        WHERE
            p1.department = p2.department
    );

-- without using a join or a group by, print the number of
-- orders for each product
CREATE TABLE orders (
    id SERIAL PRIMARY KEY,
    user_id INT,
    product_id INT REFERENCES products(id) ON DELETE CASCADE,
    paid BOOLEAN
);

INSERT INTO
    orders (user_id, product_id, paid)
VALUES
    (1, 1, TRUE),
    (2, 1, TRUE),
    (3, 2, FALSE),
    (4, 3, TRUE),
    (5, 3, TRUE),
    (6, 3, FALSE),
    (7, 4, TRUE),
    (8, 5, TRUE),
    (9, 5, TRUE),
    (10, 5, TRUE),
    (11, 6, FALSE),
    (12, 7, TRUE),
    (13, 8, TRUE),
    (14, 8, FALSE),
    (15, 9, TRUE),
    (16, 10, TRUE),
    (17, 10, TRUE),
    (18, 10, FALSE),
    (19, 11, TRUE),
    (20, 12, TRUE),
    (21, 12, FALSE),
    (22, 13, TRUE),
    (23, 14, TRUE),
    (24, 15, FALSE),
    (25, 16, TRUE),
    (26, 17, TRUE),
    (27, 18, FALSE),
    (28, 19, TRUE),
    (29, 20, TRUE);

SELECT
    name,
    (
        SELECT
            count(*)
        FROM
            orders o1
        WHERE
            o1.product_id = p1.id
    ) AS orders_count
FROM
    products AS p1;