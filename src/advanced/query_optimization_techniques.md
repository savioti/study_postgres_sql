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

Reducing subqueries is an important SQL optimization strategy, especially when working with complex queries or large datasets.

Subqueries — particularly *correlated subqueries* that run once for each row in the outer query — can severely impact performance.

Replacing them with more efficient query structures such as joins, Common Table Expressions (CTEs), or temporary tables often leads to faster and more maintainable SQL code.

### Avoid correlated subqueries

```sql
-- Inefficient: correlated subquery executed for each user
SELECT
    u.username,
    (
        SELECT COUNT(*)
        FROM orders o
        WHERE o.user_id = u.id
    ) AS total_orders
FROM users u;
```

A more efficient approach is to replace it with a join and aggregation:

```sql
-- Optimized version using a join
SELECT
    u.username,
    COUNT(o.id) AS total_orders
FROM
    users u
    LEFT JOIN orders o ON u.id = o.user_id
GROUP BY
    u.username;
```

This approach computes all counts in one pass, instead of executing a subquery per row.

### Replace repeated subqueries with CTEs

When the same subquery logic is used multiple times within a query, consider refactoring it into a Common Table Expression (CTE).

CTEs improve readability and can reduce redundant computation.

```sql
-- Using CTE to reuse filtered results
WITH completed_orders AS (
    SELECT user_id
    FROM orders
    WHERE status = 'completed'
)
SELECT
    u.username,
    COUNT(c.user_id) AS total_completed_orders
FROM
    users u
    JOIN completed_orders c ON u.id = c.user_id
GROUP BY
    u.username;
```

Here, the filtered result set (completed_orders) is generated once and reused, avoiding multiple scans of the orders table.

### Limit data in subqueries

If a subquery is necessary, always restrict the data it returns using filters, limits, or aggregates.

Returning only the relevant columns and rows minimizes the workload during query execution.

```sql
-- Subquery returns only needed columns and rows
SELECT *
FROM users
WHERE id IN (
    SELECT user_id
    FROM orders
    WHERE status = 'completed'
    LIMIT 100
);
```

This approach reduces the data volume processed in the outer query.

### Use temporary or materialized tables for heavy subqueries

For particularly expensive subqueries — especially those reused across multiple queries — it may be more efficient to store results in a temporary or materialized table.

This allows the database to avoid recalculating the same results repeatedly.

```sql
-- Materialize results for reuse
CREATE TEMP TABLE high_value_orders AS
SELECT user_id, SUM(total) AS total_spent
FROM orders
GROUP BY user_id
HAVING SUM(total) > 1000;

SELECT u.username, h.total_spent
FROM users u
JOIN high_value_orders h ON u.id = h.user_id;
```

### Summary & best practices

- Avoid correlated subqueries whenever possible — use joins or aggregations instead.
- Use CTEs to organize and reuse logic cleanly.
- Restrict the data returned by subqueries with proper filters.
- For frequently reused or expensive subqueries, store results temporarily.
- Always verify execution plans with EXPLAIN or EXPLAIN ANALYZE to ensure that optimizations have the intended effect.

## Selective Projection

Selective projection in SQL refers to the practice of retrieving only the specific columns required by a query, instead of fetching all available columns.

This technique improves query performance, reduces memory usage, and minimizes the amount of data transferred between the database and the application.

By avoiding SELECT * and explicitly naming only the necessary columns, queries become faster, clearer, and easier to maintain — especially when working with large tables or complex joins.

### Avoid using SELECT *

Using ```SELECT *``` returns all columns from a table or join result, including data that may not be needed.
This leads to increased I/O, network traffic, and processing time, particularly when the table has many columns or large text and binary fields.

```sql
-- Inefficient: returns all columns, even unused ones
SELECT *
FROM customers
WHERE city = 'New York';
```

Instead, explicitly request only the columns you need:

```sql
-- Optimized: retrieves only relevant columns
SELECT id, name, email
FROM customers
WHERE city = 'New York';
```

This reduces the amount of data read and transmitted, resulting in faster query execution.

### Benefits in joins and aggregations

When joining multiple tables or performing aggregate operations, selective projection helps the database engine process fewer columns, minimizing memory and CPU usage.

```sql
-- Inefficient: unnecessary columns from both tables
SELECT *
FROM users u
JOIN orders o ON u.id = o.user_id
WHERE o.status = 'completed';
```

Optimized example:

```sql
-- Optimized: selects only the columns required for the output
SELECT u.username, o.order_date, o.total
FROM users u
JOIN orders o ON u.id = o.user_id
WHERE o.status = 'completed';
```

By reducing the number of columns handled during the join, the database engine performs fewer data lookups and transfers, which improves execution time.

### Impact on application performance

Fetching unnecessary columns not only affects the database but also the application layer.

Every extra column increases the size of result sets sent over the network, impacting API response times and consuming additional memory in the application.

For example, an ORM query that retrieves entire entities when only a few fields are needed can significantly slow down data-intensive applications.
Selective projection ensures that only essential data is fetched, improving both backend and frontend efficiency.

### Maintaining query clarity

Explicitly naming columns in queries also enhances readability and maintainability.

Developers can easily understand what data is being used, which reduces errors during schema changes and code refactoring.

```sql
-- Clearer and safer query
SELECT id, username, created_at
FROM users
WHERE active = true;
```

This practice prevents unintended behavior if new columns are added to the table later — something that can silently affect queries using SELECT *.

### Selective Projection summary & best practices

- Always list the columns you need instead of using SELECT *.
- Use selective projection in joins and aggregates to reduce workload and memory usage.
- Fetch only the data necessary for the application — it improves both query speed and network performance.
- Keep queries clear and explicit for better maintainability.
- Revisit ORM configurations or stored procedures that implicitly use SELECT * and refactor them for selective projection.

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
