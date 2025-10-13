-- The SAVEPOINT command in a transaction allows you to set a checkpoint within the transaction.
-- If something goes wrong after the savepoint, you can use ROLLBACK TO SAVEPOINT to undo changes made after that point,
-- without rolling back the entire transaction.
BEGIN;

INSERT INTO
    accounts (user_id, balance)
VALUES
    (4, 500);

SAVEPOINT sp1;

UPDATE
    accounts
SET
    balance = balance - 100
WHERE
    user_id = 4;

-- Suppose you realize this update was wrong
ROLLBACK TO SAVEPOINT sp1;

-- The INSERT remains, but the UPDATE is undone
COMMIT;