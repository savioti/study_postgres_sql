# Query Analysis Techniques

Query analysis techniques in SQL involve examining, diagnosing, and optimizing queries to enhance their performance and efficiency.

These methods help identify performance bottlenecks, inefficient joins, unnecessary full-table scans, and poorly utilized indexes.

By understanding how queries are executed and how they interact with database resources, developers and database administrators can ensure queries run as efficiently as possible.

## EXPLAIN and EXPLAIN ANALYZE

The EXPLAIN and EXPLAIN ANALYZE commands provide insight into how the database executes a query.
They display the execution plan, which shows the steps taken by the query optimizer, including join types, index usage, and scan methods.

While EXPLAIN estimates execution cost, EXPLAIN ANALYZE actually runs the query and reports real execution times.

```sql
EXPLAIN ANALYZE
SELECT
    username
FROM
    users
WHERE
    active = true;
```

Output:

```any
Seq Scan on users  (cost=0.00..45.00 rows=15 width=12)
(actual time=0.012..0.018 rows=12 loops=1)
  Filter: (active = true)
Planning Time: 0.070 ms
Execution Time: 0.025 ms
```

## Query Profiling

Query profiling involves measuring execution time, memory usage, and resource consumption to understand where performance problems occur.

### Query Profiling with pg_stat_statements

PostgreSQL’s pg_stat_statements extension tracks query performance statistics such as execution time, number of calls, and I/O metrics.

This feature helps identify the most time-consuming or frequently executed queries across the database.

```sql
-- Enable the extension (only once per database)
CREATE EXTENSION IF NOT EXISTS pg_stat_statements;

-- View top slow queries
SELECT
    query,
    calls,
    total_exec_time,
    mean_exec_time,
    rows
FROM
    pg_stat_statements
ORDER BY
    total_exec_time DESC
LIMIT 5;
```

## Index Examination and Optimization

```sql
-- List all indexes on a specific table
SELECT
    indexname,
    indexdef
FROM
    pg_indexes
WHERE
    tablename = 'users';
```

### auto_explain

To analyze whether your query benefits from indexes, combine EXPLAIN ANALYZE with the auto_explain module to log slow queries automatically:

```sql
LOAD 'auto_explain';
SET auto_explain.log_min_duration = '100ms';
```

## Query Refactoring with CTE

Complex queries that involve multiple joins or nested aggregations can often be simplified using CTEs (Common Table Expressions).

CTEs improve readability and sometimes performance, depending on the PostgreSQL optimizer’s execution strategy.

Example of a complex query:

```sql
SELECT
    u.username,
    COUNT(o.id) AS total_orders
FROM
    users u
    JOIN orders o ON u.id = o.user_id
WHERE
    o.status = 'completed'
    AND u.active = true
GROUP BY
    u.username
HAVING
    COUNT(o.id) > 10;
```

By using CTE, you can make it explicit that you only care about the complete orders and isolate the logic:

```sql
WITH completed_orders AS (
    SELECT user_id
    FROM orders
    WHERE status = 'completed'
)
SELECT
    u.username,
    COUNT(c.user_id) AS total_orders
FROM
    users u
    JOIN completed_orders c ON u.id = c.user_id
WHERE
    u.active = true
GROUP BY
    u.username
HAVING
    COUNT(c.user_id) > 10;
```
