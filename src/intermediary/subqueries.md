# Subqueries

Subqueries, also known as nested queries or inner queries, are powerful SQL features that allow you to embed one query within another.

They enable you to perform complex operations by breaking down problems into smaller, more manageable parts.

Subqueries can be used in various clauses including ```SELECT```, ```FROM```, ```WHERE```, and ```JOIN``` conditions, providing flexibility in how you retrieve and manipulate data across related tables.

Setup:

```sql
CREATE TABLE phones (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    manufacturer VARCHAR(50) NOT NULL,
    price INTEGER NOT NULL,
    units_sold INTEGER NOT NULL
);

INSERT INTO
    phones (name, manufacturer, price, units_sold)
VALUES
    ('N1280', 'Nokia', 199, 1925),
    ('Iphone 4', 'Apple', 399, 9436),
    ('Galaxy S', 'Samsung', 299, 2359),
    ('S5620 Monte', 'Samsung', 250, 2385),
    ('N8', 'Nokia', 150, 7543),
    ('Droid', 'Motorola', 150, 8395),
    ('Wave S8500', 'Samsung', 175, 9259);
```

## Embedding in Select

Subqueries in the ```SELECT``` clause allow you to compute values dynamically for each row by referencing aggregated data or related information from other parts of the database.

This approach is particularly useful when you need to include calculated ratios, percentages, or comparisons alongside individual record details without using window functions.

```sql
-- Query that prints the name and price for each phone.
-- In addition, print out the ratio of the phones price against
-- max price of all phones (so price / max price).  Rename this
-- third column to price_ratio
SELECT
    name,
    price,
    price / (
        SELECT
            max(price)
        FROM
            phones
    ) AS price_ratio
FROM
    phones;
```

```sql
-- Subquery From's
-- Calculate the average price of phones for each manufacturer.
-- Then print the highest average price.
-- Rename this value to max_average_price
SELECT
    max(p.avg_price) AS max_average_price
FROM
    (
        SELECT
            manufacturer,
            avg(price) AS avg_price
        FROM
            phones
        GROUP BY
            manufacturer
    ) AS p;
```

## Subquery with JOIN

Using subqueries in ```JOIN``` operations enables you to combine main query results with pre-filtered or aggregated datasets.

This technique is valuable when you need to join against derived tables, such as top performers, aggregated summaries, or filtered subsets of data that would be cumbersome to create using standard ```JOIN``` conditions alone.

```sql
-- Find the manufacturer with the highest total units sold.
-- Print the manufacturer and the total units sold.
SELECT
    p.manufacturer,
    SUM(p.units_sold) AS total_units_sold
FROM
    phones AS p
    JOIN (
        SELECT
            manufacturer,
            SUM(units_sold) AS total_units_sold
        FROM
            phones
        GROUP BY
            manufacturer
        ORDER BY
            total_units_sold DESC
        LIMIT
            1
    ) AS top_manufacturer ON p.manufacturer = top_manufacturer.manufacturer
GROUP BY
    p.manufacturer;
```

## Subquery with WHERE

Subqueries in ```WHERE``` clauses provide dynamic filtering capabilities by allowing you to compare values against computed results from other queries.

This approach is essential for creating relative conditions, such as finding records that exceed average values, match specific criteria from related tables, or satisfy conditions based on aggregated data.

```sql
-- Write a query that prints out the name and price
-- of phones that have a price greater than the Samsung S5620 Monte.
SELECT
    name,
    price
FROM
    phones
WHERE
    price > (
        SELECT
            price
        FROM
            phones
        WHERE
            name = 'S5620 Monte'
    );
```

## From-less Selects

From-less ```SELECT```s utilize subqueries to generate single-row result sets without requiring a base table in the FROM clause.

This technique is particularly useful for creating summary dashboards, calculating multiple aggregate values simultaneously, or generating computed values that don't depend on specific table rows.

```sql
-- Using only subqueries, print the max price, min price, and average price of all phones.
-- Rename each column to max_price, min_price, avg_price
SELECT
    (
        SELECT
            max(price)
        FROM
            phones
    ) AS max_price,
    (
        SELECT
            min(price)
        FROM
            phones
    ) AS min_price,
    (
        SELECT
            avg(price)
        FROM
            phones
    ) AS avg_price;
```

## Subqueries with operators

Subqueries combined with comparison operators like ```ALL``` and ```SOME``` extend filtering capabilities by enabling set-based comparisons.

These operators allow you to evaluate conditions against entire result sets, making it possible to find records that satisfy relationships with multiple values from subqueries, such as being greater than all elements or at least one element in a set.

Setup:

```sql
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
```

### ALL subquery

The ```ALL``` operator requires that a comparison condition holds true for every value returned by the subquery.

This creates a strict filtering criterion where the outer query's value must satisfy the specified relationship with all elements in the subquery's result set, making it ideal for finding extreme values or outliers.

```sql
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
```

### SOME subquery

The ```SOME``` operator (which can also be written as ```ANY```) requires that a comparison condition holds true for at least one value returned by the subquery.

This creates a more flexible filtering criterion where the outer query's value only needs to satisfy the specified relationship with any single element in the subquery's result set.

```sql
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
```
