-- Create authors table
CREATE TABLE authors (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL
);

-- Create books table
CREATE TABLE books (
    id SERIAL PRIMARY KEY,
    title VARCHAR(100) NOT NULL,
    author_id INTEGER REFERENCES authors(id)
);

-- Insert authors data
INSERT INTO
    authors (name)
VALUES
    ('Sidney Sheldon'),
    ('Stephen King'),
    ('Agatha Christie'),
    ('Dr Seuss');

-- Insert books data
INSERT INTO
    books (title, author_id)
VALUES
    ('If Tomorrow Comes', 1),
    ('Nothing Lasts Forever', 1),
    ('The Dark Tower', 2),
    ('Murder At the Links', 3),
    ('Affair at Styles', 3),
    ('Cat in the Hat', 4);

SELECT
    authors.name,
    count(*)
FROM
    books
    JOIN authors ON authors.id = books.author_id
GROUP BY
    authors.name;