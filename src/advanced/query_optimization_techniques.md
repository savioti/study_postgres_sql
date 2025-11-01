# Query Optimization Techniques

## Using Indexes

### Don't create more indexes than you need

Indexes improve query performance for read operations, but each index must be updated whenever the underlying table data changes (such as ```INSERT```, ```UPDATE```, or ```DELETE```). Having too many indexes can slow down write operations and increase storage requirements. Create indexes only for columns that are frequently searched or used in ```JOIN```s and ```WHERE``` clauses.

### Use Appropriate Index Types

Different index types are optimized for different kinds of queries. Choosing the right type can greatly improve performance.

#### B-tree Index

- B-tree is the default and most common index type in most SQL databases
- it is ideal for comparisons using operators like =, <, >, <=, and >=
- B-tree indexes work best for columns frequently used in WHERE, JOIN, and ORDER BY clauses

```sql
-- Example: indexing a column used in filtering or sorting
CREATE INDEX idx_employees_salary
ON employees(salary);

SELECT *
FROM employees
WHERE salary > 50000
ORDER BY salary;
```

#### Hash Index

- hash indexes are optimized for equality comparisons (e.g., =) only
- they can be useful for columns where lookups always use exact matches, such as user IDs or codes
- however, they are not effective for range queries or sorting operations

```sql
-- Example: indexing a column used for equality checks
CREATE INDEX idx_users_email
ON users USING HASH(email);

SELECT *
FROM users
WHERE email = 'user@example.com';
```

In practice, B-tree indexes are suitable for most general-purpose queries, while hash indexes are better suited for cases that involve frequent equality lookups and no range filtering.

## Optimizing Joins

Optimizing joins in SQL involves applying techniques to improve the performance of queries that combine data from multiple tables. Because joins often touch large sets of rows and multiple tables, careful attention to join type, indexing, filtering, and join order can yield large gains in speed and efficiency.

### Choosing the appropriate join type

Using the right join type is a primary optimization strategy. ```INNER JOIN``` returns only matching rows between tables, being most efficient when only matching data is required.

```LEFT JOIN```, ```RIGHT JOIN``` and ```FULL JOIN``` return all rows from one or both tables even when there is no match, which can be useful, but can process more rows than needed and thus be slower.

```sql
SELECT u.username, o.order_date
FROM users u
     INNER JOIN orders o ON u.id = o.user_id
WHERE o.status = 'completed';
```

If you used ```LEFT JOIN``` when an ```INNER JOIN``` suffices, you might be scanning extra rows with ```NULL```s and hurting performance.

### Indexing the join columns & filtering early

For joins to perform well, the join keys and any filtered columns need good support:

Apply ```WHERE``` filters before the join if possible — this reduces the volume of rows participating in the join.

```sql
-- Better: filter orders first, then join
SELECT u.username, o.order_date
FROM users u
     JOIN orders o ON u.id = o.user_id
WHERE o.status = 'completed'
  AND u.active = true;
```

Ensure the columns used in the ON clause are indexed (especially the foreign key side).

For example: ```orders.user_id``` should be indexed when joining to ```users.id```.

### Minimizing number of joins and avoiding unnecessary columns

- each additional join adds cost, try to limit joins to only the tables you need
- avoid SELECT * in queries with joins, pulling unnecessary columns increases I/O and memory use

## Reducing Subqueries

## Selective Projection

## General Tips

### Avoid SELECT *

Selecting all columns increases I/O and memory usage unnecessarily. Always fetch only what’s required.

```sql
-- Inefficient
SELECT * FROM users;

-- Efficient
SELECT username, email FROM users;
```

### Use LIMIT and Window Functions for Large Results

When analyzing or paginating large datasets, limit the number of rows processed to prevent unnecessary load.

```sql
SELECT
    username,
    created_at
FROM
    users
ORDER BY
    created_at DESC
LIMIT 50;
```

### Partition Large Tables

For massive datasets, table partitioning improves performance by limiting query scans to relevant partitions.

```sql
CREATE TABLE sales (
    id SERIAL PRIMARY KEY,
    sale_date DATE,
    amount NUMERIC
) PARTITION BY RANGE (sale_date);

CREATE TABLE sales_2025 PARTITION OF sales
FOR VALUES FROM ('2025-01-01') TO ('2026-01-01');
```

### Only use wilcards at the of a phrase

Placing the wildcard (%) only at the end allows the database to use indexes, speeding up the search. Wildcards at the beginning ('%Sam%') prevent index usage and make the search slower.

Avoid this:

```sql
SELECT * FROM products WHERE name LIKE '%Sam%';
```

Prefer this:

```sql
SELECT * FROM products WHERE name LIKE 'Sam%';
```

### Avoid SELECT DISTINCT if possible

SELECT DISTINCT forces the database to eliminate duplicates, which can be costly with large data volumes. Using alternatives like GROUP BY or filtering duplicates at the source can be more efficient.

Try to use GROUP BY if appropriate:

```sql
SELECT country FROM users GROUP BY country;
```

### Run large queries during off-peak hours

If you need to run a heavy report, schedule it for times with less database usage, such as late at night or early morning, to avoid impacting other users.

### Prefer JOIN over subqueries

JOIN operations are generally more efficient and easier for the database to optimize. When you use a subquery in a WHERE clause, the database may need to execute the subquery for each row in the outer query, which can be slow, especially with large datasets.

With a JOIN, the database can combine tables using indexes and process the relationship in a single pass, often resulting in faster execution and better use of resources. Additionally, JOIN queries are usually easier to read and maintain, making your code more understandable for others.

```sql
SELECT name
FROM employees
WHERE department_id IN (
    SELECT id FROM departments WHERE location = 'New York'
);
```

```sql
SELECT e.name
FROM employees e
JOIN departments d ON e.department_id = d.id
WHERE d.location = 'New York';
```

### Use EXISTS Instead of IN

If you've used IN and NOT IN, try switching to EXISTS and NOT EXISTS. For example, consider the following query which uses IN:

```sql
SELECT * FROM Orders
WHERE CustomerID IN (SELECT CustomerID FROM Customers WHERE City = 'Berlin');
```

This query returns all orders placed by customers from Berlin.

You could rewrite that using EXISTS, which may often be more efficient:

```sql
SELECT o.* FROM Orders o WHERE EXISTS (SELECT 1 FROM Customers c WHERE c.City = 'Berlin' AND c.CustomerID = o.CustomerID);
```

This depends on the subquery results, if the subquery results are very large then use EXISTS. If the subquery results are very small then IN is still faster.
