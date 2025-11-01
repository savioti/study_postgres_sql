# Indexes

## When should you create an index?

Consider creating indexes for:

- columns in your ```WHERE``` clauses
- columns in your ```JOIN``` clauses
- ```FOREIGN KEY``` columns

In most databases, indexes are automatically created for ```PRIMARY KEY``` and ```UNIQUE``` columns.

Avoid creating indexes when:

- column has few distinct values
- you are not sure you will need
  
Creating too much indexes will slow down ```INSERT```, ```UPDATE``` and ```DELETE``` operations.

## Types of indexes

### B-tree

A Balanced Tree is the default index type. It will be the type set if the type is not specified.

```sql
CREATE INDEX idx_photos_user_id ON photos(user_id);
```

### Hash

A Hash Index uses a hash table internally to map key values to their corresponding rows.

It is designed specifically for equality comparisons (using the ```=``` operator), not for range queries.

```sql
CREATE INDEX idx_users_email_hash ON users USING HASH(email);
```

This index improves performance for queries like:

```sql
SELECT * FROM users WHERE email = 'user@example.com';
```

However, it will not help with conditions such as ```email > 'm@example.com'``` or sorting operations.

### GIN (Generalized Inverted Index)

A GIN index is designed for indexing composite or multi-value data types, such as arrays, JSONB documents, and full-text search vectors.
Instead of mapping one key to one row, a GIN index maps multiple keys from a single row to the indexed entry.

```sql
CREATE INDEX idx_posts_tags_gin ON posts USING GIN(tags);
```

Example usage:

```sql
SELECT * FROM posts WHERE tags @> ARRAY['sql'];
```

This index allows efficient searches for array elements or JSONB keys.

It is particularly effective for full-text search, when combined with the to_tsvector() function:

```sql
CREATE INDEX idx_articles_tsv_gin 
ON articles USING GIN(to_tsvector('english', content));

SELECT * FROM articles
WHERE to_tsvector('english', content) @@ to_tsquery('optimization');
```

### GiST (Generalized Search Tree)

A GiST index is a flexible, extensible tree structure that supports a wide range of data types and custom operators.
It is often used for geometric, range, or full-text search operations, and is the foundation for several specialized PostgreSQL index types.

```sql
CREATE INDEX idx_locations_geom_gist ON locations USING GiST(geom);
```

Example usage with geometric data:

```sql
SELECT * FROM locations
WHERE geom && ST_MakeEnvelope(-50, -25, -40, -15, 4326);
```

Common use cases for GiST:

- Spatial data (PostGIS)
- Range queries (int4range, tsrange)
- Text similarity (using the pg_trgm extension)

**Key difference:**
While GIN indexes are optimized for matching contained values (e.g., elements in arrays or words in text), GiST indexes are optimized for proximity or overlap (e.g., geometric regions or numeric ranges).

### Function-based

Any query that uses a function or expression on a column in the where clause will almost never use the index of the column that's part of the function/expression.

```sql
CREATE INDEX idx_emp_mth_salary ON employees(annual_salary / 12);
```

This index should be used when executing a query like the one below:

```sql
SELECT employee_id, annual_salary, annual_salary / 12 AS monthly_salary
FROM employees
WHERE annual_salary / 12 >= 10000;
```

## Managing Indexes

Managing indexes in SQL involves creating, modifying, and removing indexes to optimize database performance. Proper index management ensures that queries run efficiently without introducing unnecessary overhead to data modification operations.

### Dropping indexes

Unnecessary or unused indexes can be removed to reduce storage overhead and speed up data modification operations. Use ```DROP INDEX``` to delete an index:

```sql
DROP INDEX idx_users_email;
```

Indexes tied to constraints (like those from PRIMARY KEY or UNIQUE) are automatically dropped when the constraint is removed.

### Monitoring and maintenance

Database administrators should regularly monitor index usage and performance using system views like PostgreSQL’s pg_stat_user_indexes and pg_stat_all_indexes:

```sql
SELECT
    relname AS table_name,
    indexrelname AS index_name,
    idx_scan AS times_used
FROM
    pg_stat_user_indexes
ORDER BY
    idx_scan DESC;
```

### REINDEX

As data grows or changes significantly, indexes may become fragmented. Periodic maintenance such as rebuilding or reindexing helps maintain efficiency:

```sql
REINDEX TABLE users;
```

Balancing the number of indexes, their types, and their maintenance frequency is essential for keeping query performance optimized without degrading write performance.
