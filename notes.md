# points of note

## query execution order

![image](https://github.com/user-attachments/assets/2d766609-9931-4762-b77e-dea5c5146ecb)

## <> and !=

both operators do the exact same thing and are widely supported, but the standard is considered to be <>

## foreign key

- when you a have a one-to-many relationship (or many-to-one), the foreign key should always be placed in the "many" table
- you can't set a foreign key referencing a value that doesn't exist

### deletion constraints

#### on delete restrict

throws an error if you try to delete a value that is being used as a foreign key somewhere

#### on delete no action

throws an error if you try to delete a value that is being used as a foreign key somewhere

#### on delete cascade

delete all the items with the associated values as foreign keys

#### on delete set null

set any foreign key value that is being deleted to null

#### on delete set default

set any foreign key value that is being deleted to a default value if possible

## serial

serial is a pseudo-type that simplifies the creation of auto-incrementing integer columns, commonly used as primary keys

## REFERENCES

shorthand syntax to indicate a foreign key reference to another table's column
