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
    (1, 'Shirt', 'Toys', 876, 3),
    (2, 'Towels', 'Outdoors', 412, 16),
    (3, 'Bacon', 'Movies', 10, 6),
    (4, 'Ball', 'Industrial', 328, 23),
    (5, 'Fish', 'Industrial', 796, 10),
    (6, 'Mouse', 'Grocery', 989, 11),
    (7, 'Computer', 'Home', 298, 2);

-- > ALL subquery
-- Show the name, department and price of products that are more
-- expensive than all products in the "industrial" department
SELECT
    name,
    department,
    price
FROM
    products
WHERE
    price > ALL (
        SELECT
            price
        FROM
            products
        WHERE
            department = 'Industrial'
    );

-- > SOME subquery
-- Show the name, department and price of products that are more
-- expensive than at least one product in the "industrial" department
SELECT
    name,
    department,
    price
FROM
    products
WHERE
    price > SOME (
        SELECT
            price
        FROM
            products
        WHERE
            department = 'Industrial'
    );