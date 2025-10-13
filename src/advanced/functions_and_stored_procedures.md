# Functions and stored procedures

## Functions

Use functions when you need to compute and return a value, and you do not need to change data in the database.

- must have at least one parameter.
- must return a result (value or table).
- cannot modify database objects or data (no side effects).
- used mainly for calculations, data transformations, or returning computed results.
- can be embedded in SELECT statements
- can't use try-catch
- can be called from procedures

```sql
-- Function that returns the ratio between weight and distance for a shipment
CREATE FUNCTION shipment_ratio(shipment_id INT) RETURNS NUMERIC AS $$
DECLARE
    shipment_weight NUMERIC;
    shipment_distance NUMERIC;
BEGIN
    SELECT weight, distance
    INTO shipment_weight, shipment_distance
    FROM shipments
    WHERE id = shipment_id;

    IF shipment_distance = 0 THEN
        RETURN NULL;
    END IF;

    RETURN shipment_weight / shipment_distance;
END;
$$ LANGUAGE plpgsql;

-- Usage
SELECT shipment_ratio(1);
```

## Stored Procedures

Use stored procedures when you need to perform operations that change data, manage transactions, or execute multiple SQL statements as a batch.

- may or may not have parameters (in PostgreSQL, procedures can have parameters).
- do not need to return a result.
- can modify database objects and data (side effects allowed).
- used for executing complex logic, batch operations, or grouping multiple SQL statements into a transaction.
- can use try-catch

```sql
-- Procedure that updates the weight of a shipment and logs the change
CREATE PROCEDURE update_shipment_weight(
    shipment_id INT,
    new_weight NUMERIC
)
LANGUAGE plpgsql
AS $$
BEGIN
    UPDATE shipments
    SET weight = new_weight
    WHERE id = shipment_id;
END;
$$;

-- Usage
CALL update_shipment_weight(1, 25.5);
```
