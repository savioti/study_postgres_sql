-- Drop table example
-- The DROP TABLE command is a Data Definition Language (DDL)
-- instruction that permanently deletes a table from the database.
-- This action removes not only all the records within the table,
-- but also its structure, making the table no longer exist in the database.
-- Executing DROP TABLE gets rid of the table itself, its contents,
-- and any related elements such as indexes, constraints, and triggers.
-- In contrast to TRUNCATE TABLE, which only clears the data but leaves
-- the table structure intact, DROP TABLE erases the table and everything linked to it.
DROP TABLE IF EXISTS photos;