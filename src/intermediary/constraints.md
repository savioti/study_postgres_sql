# Constraints

SQL integrity constraints serve as enforced rules on database tables to guarantee data reliability. These safeguards work to eliminate inconsistencies, implement business logic, and maintain accurate representation of real-world entities and their connections within the database.

## PRIMARY KEY

Serves as the distinct identifier for every table record. This rule is established within the CREATE TABLE statement, coming after the column's data type declaration.

```sql
CREATE TABLE products (
    id INTEGER PRIMARY KEY,
)
```

## FOREIGN KEY

Creates connections between tables by pointing to a primary key in a different table. This can be set up during table creation or added later through modification.

```sql
ALTER TABLE products
ADD CONSTRAINT fk_department_id
FOREIGN KEY (department_id)
REFERENCES departments(id);
```

```sql
CREATE TABLE products (
    department_id integer REFERENCES departments(id)
);
```

## NOT NULL

Guarantees that a column must always contain a value and cannot be left empty. This rule is implemented in the CREATE TABLE command after defining the column's data type.

```sql
CREATE TABLE products (
    price INTEGER NOT NULL,
)
```

## UNIQUE

Makes certain that every entry in a column or combination of columns remains distinct throughout the table. This is specified in the CREATE TABLE command following the column's data type definition.

```sql
CREATE TABLE products (
    barcode VARCHAR(48) UNIQUE,
)
```

## DEFAULT

Assigns a predetermined value to a column when no specific value is provided during data insertion. This can be configured either at table creation or through subsequent modifications.

```sql
ALTER TABLE products
ALTER COLUMN category SET DEFAULT 'Uncategorized';
```

```sql
CREATE TABLE products (
    category VARCHAR(24) DEFAULT 'Uncategorized',
)
```

## CHECK

Verifies that every value in a column meets predetermined criteria. This validation can be implemented during table creation or added later through table modification.

```sql
ALTER TABLE
    products
ADD
    CONSTRAINT positive_price CHECK (price > 0);
```

```sql
CREATE TABLE products (
    price INTEGER,
    CONSTRAINT positive_price CHECK (price > 0)
)
```

### Range conditions

Enables restriction of column values to remain within specified boundaries.

```sql
ALTER TABLE products
ADD CONSTRAINT discount_range 
CHECK (discount BETWEEN 5 AND 95);
```

### List conditions

Permits verification that a column's value corresponds to one of the predefined options in a specified list.

```sql
ALTER TABLE products
ADD CONSTRAINT valid_size 
CHECK (size IN ('NA', 'S', 'M', 'L', 'XL'));
```

### Comparison conditions

Allows evaluation of column values against specific comparative criteria (such as greater than, less than, or equal to).

```sql
ALTER TABLE products
ADD CONSTRAINT positive_price
CHECK (price > 0);
```

### Pattern matching conditions

Enables validation of text data using pattern recognition techniques, typically with operators like LIKE or SIMILAR TO.

```sql
ALTER TABLE products
ADD CONSTRAINT valid_sku 
CHECK (sku LIKE 'PRD-[0-9][0-9][0-9][0-9]');
```

### Logical conditions

Supports combining multiple validation rules through logical operators (AND, OR, NOT) to create complex conditional requirements.

```sql
ALTER TABLE products
ADD CONSTRAINT valid_discount_product 
CHECK (
    (discount > 0 AND sale_price IS NOT NULL) 
    OR 
    (discount = 0 AND sale_price IS NULL)
);
```

### Composite conditions

Imposes validation rules that involve multiple columns simultaneously, ensuring relational integrity between different data fields.

```sql
ALTER TABLE products
ADD CONSTRAINT valid_profit_margin 
CHECK (sale_price - cost_price > cost_price * 0.10);
```
