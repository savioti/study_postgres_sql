# SQL Isolation Levels

Isolation levels determine how your transactions are affected by other concurrent transactions.

- the higher the isolation level, the less affected the transaction is
- higher levels of isolation bring more accuracy, but it may be at a slower speed
  
There are four isolation levels and the rule of thumb is to use the lowest level that gives the application the consistency it needs.

## READ UNCOMMITTED

Allows transactions to read data that has been modified but not yet committed by other transactions. This can lead to dirty reads, where uncommitted changes are visible.

- weakest isolation level
- should almost never be used
- allows dirty reads, nonrepeatable reads, and phantom reads
- only a few databases still implement this
- offers highest concurrency

## READ COMMITTED

Guarantees that a transaction only sees data that has been committed before each query starts. Each statement within the transaction sees a new snapshot of committed data. This prevents dirty reads but allows data to change between queries.

- generally the weakest isolation level implemented in most databases
- popular default option
- prevents dirty reads only allowing reading of committed data
- non-repeatable reads, phantom reads and serialization anomalies are possible

## REPEATABLE READ

Ensures that if a row is read twice in the same transaction, it will return the same value each time. It does so by either locking read rows (in lock-based systems) or by using a snapshot (in MVCC systems).

- intermediate level of isolation
- transaction retry errors can occur
- prevents the nonrepeatable read anomaly
- may lead to transaction retries under high concurrency

## SERIALIZABLE

Provides full isolation by making transactions behave as if executed sequentially. Prevents dirty reads, nonrepeatable reads, and phantom reads. Usually implemented via predicate locks or Serializable Snapshot Isolation (SSI).

- highest isolation level
- fully prevents concurrency anomalies
- may reduce performance and cause frequent retries
- recommended for critical consistency use cases (e.g., financial operations)
- safest but least concurrent
