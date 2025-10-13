# ACID

## Basic concepts

### Atomicity

All operations within a transaction are completed successfully, or none are applied.

```sql
BEGIN;

INSERT INTO
    accounts (user_id, balance)
VALUES
    (1, 1000);

INSERT INTO
    accounts (user_id, balance)
VALUES
    (2, 1500);

UPDATE
    accounts
SET
    balance = balance - 200
WHERE
    user_id = 1;

UPDATE
    accounts
SET
    balance = balance + 200
WHERE
    user_id = 2;

COMMIT;
```

If any of the above operations fail, the entire transaction is rolled back.
```ROLLBACK;``` Uncomment this line to simulate a failure and rollback the transaction.
The balances of user_id 1 and 2 remain unchanged if rollback is executed.
If commit is executed, user_id 1's balance is 800 and user_id 2's balance is 1700.

### Consistency

Ensures that a transaction brings the database from one valid state to another, maintaining database invariants.

Example: Ensuring that an account balance cannot be negative.

```sql
BEGIN;

UPDATE
    accounts
SET
    balance = balance - 2000
WHERE
    user_id = 1;
```

This would make the balance negative
This operation violates the consistency rule if there's a constraint that balance cannot be negative.
```COMMIT;```; This should fail if there's a ```CHECK``` constraint on balance >= 0
```ROLLBACK;```;

- Rollback to maintain consistency
- The balance of user_id 1 remains unchanged.
  
### Isolation

Transactions are isolated from each other until they are completed.

Example: Two transactions trying to update the same account balance simultaneously.

Transaction 1

```sql
BEGIN;

UPDATE
    accounts
SET
    balance = balance + 100
WHERE
    user_id = 1;
```

Transaction 2

```sql
BEGIN;

UPDATE
    accounts
SET
    balance = balance + 200
WHERE
    user_id = 1;
```

```sql
COMMIT; -- Commit Transaction 1
COMMIT; -- Commit Transaction 2
ROLLBACK;
```

(Rollback both transactions for demonstration purposes)
The final balance of user_id 1 will reflect only one of the transactions if isolation is properly maintained.

### Durability

Once a transaction is committed, it will remain so, even in the event of a system failure.

Example: After committing a transaction, the changes are saved permanently.

```sql
BEGIN;

UPDATE
    accounts
SET
    balance = balance + 500
WHERE
    user_id = 1;

COMMIT;
```

Even if the system crashes now, the balance update for user_id 1 will persist.
The balance of user_id 1 is now increased by 500 permanently.

## Common Issues

### Dirty Reads

A transaction reads data written by a concurrent uncommitted transaction.

Example: Transaction 1 updates a balance but does not commit. Transaction 2 reads the uncommitted balance.

Transaction 1

```sql
BEGIN;

UPDATE
    accounts
SET
    balance = balance + 300
WHERE
    user_id = 2;
```

Transaction 2

```sql
BEGIN;

SELECT
    balance
FROM
    accounts
WHERE
    user_id = 2;
```

This read might show the uncommitted balance from Transaction 1

Rollback Transaction 1

```sql
ROLLBACK;
```

Rollback Transaction 2

```sql
ROLLBACK;
```

The balance of user_id 2 remains unchanged.

### Non-Repeatable Reads

A transaction reads the same row twice and gets different data each time because another transaction modified the row in between.

Transaction 1

```sql
BEGIN;

SELECT
    balance
FROM
    accounts
WHERE
    user_id = 1;
```

Transaction 2

```sql
BEGIN;

UPDATE
    accounts
SET
    balance = balance + 400
WHERE
    user_id = 1;

COMMIT;
```

Commit Transaction 2

Transaction 1 reads the balance again

```sql
SELECT
    balance
FROM
    accounts
WHERE
    user_id = 1;

ROLLBACK;
```

Rollback Transaction 1

The balance of user_id 1 reflects the update from Transaction 2.

### Phantom Reads

A transaction re-executes a query returning a set of rows that satisfy a search condition and finds that the set of rows satisfying the condition has changed due to another recently-committed transaction.

Transaction 1

```sql
BEGIN;

SELECT
    *
FROM
    accounts
WHERE
    balance > 1000;
```

Transaction 2

```sql
BEGIN;

INSERT INTO
    accounts (user_id, balance)
VALUES
    (3, 1200);

```

Commit Transaction 2

```sql
COMMIT;
```

## How SQL databases achieve ACID

To avoid these common issues, databases use a system called locking.

When a transaction begins, the database locks the data the transaction it's working with until the transaction is completed so other transactions cannot work with the data that's being changed.
