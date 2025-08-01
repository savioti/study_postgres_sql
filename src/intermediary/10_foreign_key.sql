CREATE TABLE photos (
    id serial PRIMARY KEY,
    url varchar(255),
    user_id integer REFERENCES users(id)
);

INSERT INTO
    photos (url, user_id)
VALUES
    ('http://example.com/photo1.jpg', 1),
    ('http://example.com/photo2.jpg', 2),
    ('http://example.com/photo3.jpg', 1),
    ('http://example.com/photo4.jpg', 3);

SELECT
    *
FROM
    photos;