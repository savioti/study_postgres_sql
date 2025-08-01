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
    ('NewUser1'),
    ('NewUser2');

INSERT INTO
    photos (url, user_id)
VALUES
    ('https://santina.net', 3),
    ('https://kailyn.name', 3),
    ('http://marjolaine.name', 1),
    ('http://jerrold.org', 2),
    ('http://colten.net', 2),
    ('http://kolby.org', 1);

INSERT INTO
    comments (contents, user_id, photo_id)
VALUES
    ('Non est totam.', 1, 1),
    ('Fuga et iste beatae.', 2, 2),
    ('Molestias tempore est.', 3, 2),
    ('Perferendis cumque eligendi.', 4, 3),
    ('Nihil quo voluptatem placeat.', 5, 3),
    ('Rerum dolor sunt sint.', 6, 3);

-- right join example
SELECT
    url,
    username
FROM
    photos
    RIGHT JOIN users ON users.id = photos.user_id;

-- output:
-- url                     | username
-- ----------------------- | -------------------
-- https://santina.net     | Alfredo66
-- https://kailyn.name     | Alfredo66
-- http://marjolaine.name  | Reyna.Marvin
-- http://jerrold.org      | Micah.Cremin
-- http://colten.net       | Micah.Cremin
-- http://kolby.org        | Reyna.Marvin
-- NULL                    | NewUser1
-- NULL                    | NewUser2;