-- setup
CREATE TABLE users(
    id SERIAL PRIMARY KEY,
    username VARCHAR(50)
);

CREATE TABLE photos (
    id SERIAL PRIMARY KEY,
    url VARCHAR(200),
    user_id INTEGER REFERENCES users(id) ON DELETE CASCADE
);

CREATE TABLE comments (
    id SERIAL PRIMARY KEY,
    contents VARCHAR(240),
    user_id INTEGER REFERENCES users(id) ON DELETE CASCADE,
    photo_id INTEGER REFERENCES photos(id) ON DELETE CASCADE
);

INSERT INTO
    users (username)
VALUES
    ('Reyna.Marvin'),
    ('Micah.Cremin'),
    ('Alfredo66'),
    ('Gerard_Mitchell42'),
    ('Frederique_Donnelly');

INSERT INTO
    photos (url, user_id)
VALUES
    ('https://santina.net', 3),
    ('https://alayna.net', 5),
    ('https://kailyn.name', 3),
    ('http://marjolaine.name', 1),
    ('http://chet.net', 5),
    ('http://jerrold.org', 2),
    ('https://meredith.net', 4),
    ('http://isaias.net', 4),
    ('http://dayne.com', 4),
    ('http://colten.net', 2),
    ('https://adelbert.biz', 5),
    ('http://kolby.org', 1),
    ('https://deon.biz', 2),
    ('https://elinore.name', 2),
    ('http://sasha.com', 3);

INSERT INTO
    comments (contents, user_id, photo_id)
VALUES
    (
        'Quo velit iusto ducimus quos a incidunt nesciunt facilis.',
        2,
        4
    ),
    ('Non est totam.', 5, 5),
    ('Fuga et iste beatae.', 3, 3),
    ('Molestias tempore est.', 1, 5),
    (
        'Est voluptatum voluptatem voluptatem est ullam quod quia in.',
        1,
        5
    ),
    ('Aut et similique porro ullam.', 1, 3),
    (
        'Fugiat cupiditate consequatur sit magni at non ad omnis.',
        1,
        2
    ),
    (
        'Accusantium illo maiores et sed maiores quod natus.',
        2,
        5
    ),
    ('Perferendis cumque eligendi.', 1, 2),
    ('Nihil quo voluptatem placeat.', 5, 5),
    ('Rerum dolor sunt sint.', 5, 2),
    (
        'Id corrupti tenetur similique reprehenderit qui sint qui nulla tenetur.',
        2,
        1
    ),
    ('Maiores quo quia.', 1, 5),
    (
        'Culpa perferendis qui perferendis eligendi officia neque ex.',
        1,
        4
    ),
    (
        'Minima dolorem reiciendis excepturi culpa sapiente eos deserunt ut.',
        3,
        3
    );

-- creating views from a single table
CREATE VIEW user_photos AS
SELECT
    u.id AS user_id,
    u.username,
    p.id AS photo_id,
    p.url
FROM
    users u
    JOIN photos p ON u.id = p.user_id;

-- creating views from multiple tables
CREATE VIEW photo_comments AS
SELECT
    p.id AS photo_id,
    p.url,
    c.id AS comment_id,
    c.contents,
    u.id AS commenter_id,
    u.username AS commenter_username
FROM
    photos p
    JOIN comments c ON p.id = c.photo_id
    JOIN users u ON c.user_id = u.id;

-- querying views
SELECT
    *
FROM
    user_photos;

-- modifying/replacing views
CREATE
OR REPLACE VIEW user_photos AS
SELECT
    u.id AS user_id,
    u.username,
    p.id AS photo_id,
    p.url,
    COUNT(c.id) AS comment_count
FROM
    users u
    JOIN photos p ON u.id = p.user_id
    LEFT JOIN comments c ON p.id = c.photo_id
GROUP BY
    u.id,
    p.id,
    u.username,
    p.url;

-- dropping views
DROP VIEW IF EXISTS photo_comments;