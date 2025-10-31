CREATE TABLE products (
    id SERIAL PRIMARY KEY,
    name varchar(50),
    price integer,
    weight integer
);

INSERT INTO
    products (name, price, weight)
VALUES
    ('Laptop', 350000, 220),
    ('Smartphone', 180000, 18),
    ('Tablet', 120000, 40),
    ('Monitor', 90000, 350),
    ('Keyboard', 12000, 60),
    ('Mouse', 8000, 10),
    ('Printer', 65000, 600),
    ('Gaming Chair', 110000, 1500),
    ('Headset', 25000, 035),
    ('Webcam', 20000, 9),
    ('External Hard Drive', 40000, 25),
    ('Flash Drive', 6000, 2);

-- UNION example:
(
    SELECT
        *
    FROM
        products
    ORDER BY
        price DESC
    LIMIT
        3
)
UNION
(
    SELECT
        *
    FROM
        products
    ORDER BY
        price / weight DESC
    LIMIT
        3
)
ORDER BY
    price DESC;

-- output:
-- id	name	                price	weight
-- 1	Laptop	                350000	220
-- 2	Smartphone	            180000	18
-- 3	Tablet	                120000	40
-- 4	Flash Drive	            6000	2
--
-- INTERSECT example:
(
    SELECT
        *
    FROM
        products
    ORDER BY
        price DESC
    LIMIT
        3
)
INTERSECT
(
    SELECT
        *
    FROM
        products
    ORDER BY
        price / weight DESC
    LIMIT
        3
)
ORDER BY
    price DESC;

-- output:
-- id	name	                price	weight
-- 2	Smartphone	            180000	18
-- 3	Tablet	                120000	40
--
-- EXCEPT example:
(
    SELECT
        *
    FROM
        products
    ORDER BY
        price / weight DESC
    LIMIT
        6
)
EXCEPT
    (
        SELECT
            *
        FROM
            products
        WHERE
            weight >= 100
    )
ORDER BY
    price DESC;