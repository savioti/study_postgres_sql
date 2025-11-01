# GRANT and REVOKE

The ```GRANT``` and ```REVOKE``` statements are used to grant or revoke privileges like ```SELECT```, ```UPDATE```, ```INSERT``` and ```DELETE``` to tables or views.

## GRANT

If we need to grant the user "SAVIOTI" the ```UPDATE``` privilege to a table called ```products```, we would use the following command:

```sql
GRANT UPDATE ON products TO SAVIOTI WITH GRANT OPTION
```

## REVOKE

If the user SAVIOTI should no longer have the privilege to use ```UPDATE``` on the table products, we could revoke his access by using the following command:

```sql
REVOKE UPDATE ON TABLE products FROM SAVIOTI
```
