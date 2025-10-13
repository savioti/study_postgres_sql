# Query Optimization tips

## General tips

### Select only the columns you need

Selecting only the columns needed decreases the volume of data being processed and transferred, making the query faster and saving database and network resources.

Instead of:

```sql
SELECT * FROM users;
```

Use:

```sql
SELECT id, username FROM users;
```

### Use LIMIT to preview query results

Using LIMIT lets you quickly view a sample of the results without overloading the database.

Example:

```sql
SELECT id, username FROM users LIMIT 10;
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

### Don't create more indexes than you need

Indexes improve query performance for read operations, but each index must be updated whenever the underlying table data changes (such as INSERT, UPDATE, or DELETE). Having too many indexes can slow down write operations and increase storage requirements. Create indexes only for columns that are frequently searched or used in JOINs and WHERE clauses.
