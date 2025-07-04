-- This SQL query calculates the population density of cities by dividing the population by the area.
SELECT
    name,
    population / area AS population_density
FROM
    cities
WHERE
    area > 0;