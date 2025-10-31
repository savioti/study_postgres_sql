# GROUP BY

The ```GROUP BY``` clause in SQL is used to organize rows that have the same values in one or more columns into summary groups.

It’s commonly used with aggregate functions such as ```COUNT()```, ```SUM()```, ```AVG()```, ```MAX()```, and ```MIN()``` to produce summarized data for each group.

This is particularly useful for analyzing datasets and drawing insights from aggregated information.

```sql
SELECT
    country,
    COUNT(*) AS total_cities,
    AVG(population) AS average_population,
    SUM(area) AS total_area
FROM
    cities
GROUP BY
    country;

-- output:
-- country  total_cities    average_population      total_area
-- China    1               22125000.000000000000   4015
-- USA      2                6200000.000000000000   2091
-- India    1               28125000.000000000000   2240
-- Japan    1               38505000.000000000000   8223
-- Brazil   3               10061000.000000000000   4556
```

## GROUP BY with JOIN

The ```GROUP BY``` clause can also be used in conjunction with ```JOIN``` operations to summarize combined data from multiple tables.

In this example, we use two related tables — countries and cities — to show how to aggregate information about cities per country by joining them on their relationship.

```sql
SELECT
    countries.name AS country,
    COUNT(cities.id) AS total_cities,
    AVG(cities.population) AS average_population
FROM
    cities
    JOIN countries ON countries.id = cities.country_id
GROUP BY
    countries.name;
```

## GROUP BY with HAVING

The ```HAVING``` clause filters grouped data after aggregation, unlike ```WHERE```, which filters rows before grouping. It allows conditions to be applied to the results of aggregate functions.

This query filters grouped results so that only countries with cities having a population greater than 20 million are returned.

```sql
SELECT
    country,
    population
FROM
    cities
GROUP BY
    country,
    population
HAVING
    population > 20000000;
```

This query filters countries to include only those with more than one city in the dataset.

```sql
SELECT
    country
FROM
    cities
GROUP BY
    country
HAVING
    COUNT(*) > 1;
```

## GROUP BY with Multiple Columns

The ```GROUP BY``` clause can also operate on more than one column at a time. This allows you to create more granular groupings based on combinations of attributes.

For example, grouping by both country and a derived population category provides detailed insights into regional distributions.

```sql
SELECT
    country,
    CASE
        WHEN population >= 20000000 THEN 'Large City'
        WHEN population BETWEEN 5000000 AND 19999999 THEN 'Medium City'
        ELSE 'Small City'
    END AS population_category,
    COUNT(*) AS total_cities,
    AVG(area) AS average_area
FROM
    cities
GROUP BY
    country,
    population_category
ORDER BY
    country,
    population_category;
```
