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
    ('https://marina.com', 5),
    ('http://johnson.info', 1),
    ('https://linda.info', 2),
    ('https://tyrique.info', 4),
    ('http://buddy.info', 5),
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
        'Reprehenderit voluptates rerum qui veritatis ut.',
        1,
        1
    ),
    ('Aut ipsum porro deserunt maiores sit.', 5, 3),
    ('Aut qui eum eos soluta pariatur.', 1, 1),
    (
        'Praesentium tempora rerum necessitatibus aut.',
        4,
        3
    ),
    ('Magni error voluptas veniam ipsum enim.', 4, 2),
    (
        'Et maiores libero quod aliquam sit voluptas.',
        2,
        3
    ),
    ('Eius ab occaecati quae eos aut enim rem.', 5, 4),
    ('Et sit occaecati.', 4, 3),
    (
        'Illum omnis et excepturi totam eum omnis.',
        1,
        5
    ),
    ('Nemo nihil rerum alias vel.', 5, 1),
    ('Voluptas ab eius.', 5, 1),
    (
        'Dolor soluta quisquam voluptatibus delectus.',
        3,
        5
    ),
    ('Consequatur neque beatae.', 4, 5),
    ('Aliquid vel voluptatem.', 4, 5),
    ('Maiores nulla ea non autem.', 4, 5),
    ('Enim doloremque delectus.', 1, 4),
    ('Facere vel assumenda.', 2, 5),
    (
        'Fugiat dignissimos dolorum iusto fugit voluptas et.',
        2,
        1
    ),
    ('Sed cumque in et.', 1, 3),
    (
        'Doloribus temporibus hic eveniet temporibus corrupti et voluptatem et sint.',
        5,
        4
    ),
    ('Quia dolorem officia explicabo quae.', 3, 1),
    ('Ullam ad laborum totam veniam.', 1, 2),
    (
        'Et rerum voluptas et corporis rem in hic.',
        2,
        3
    ),
    ('Tempora quas facere.', 3, 1),
    (
        'Rem autem corporis earum necessitatibus dolores explicabo iste quo.',
        5,
        5
    ),
    (
        'Animi aperiam repellendus in aut eum consequatur quos.',
        1,
        2
    ),
    ('Enim esse magni.', 4, 3),
    ('Saepe cumque qui pariatur.', 4, 4),
    ('Sit dolorem ipsam nisi.', 4, 1),
    ('Dolorem veniam nisi quidem.', 2, 5),
    (
        'Porro illum perferendis nemo libero voluptatibus vel.',
        3,
        3
    ),
    (
        'Dicta enim rerum culpa a quo molestiae nam repudiandae at.',
        2,
        4
    ),
    (
        'Consequatur magnam autem voluptas deserunt.',
        5,
        1
    ),
    ('Incidunt cum delectus sunt tenetur et.', 4, 3),
    ('Non vel eveniet sed molestiae tempora.', 2, 1),
    (
        'Ad placeat repellat et veniam ea asperiores.',
        5,
        1
    ),
    ('Eum aut magni sint.', 3, 1),
    (
        'Aperiam voluptates quis velit explicabo ipsam vero eum.',
        1,
        3
    ),
    (
        'Error nesciunt blanditiis quae quis et tempora velit repellat sint.',
        2,
        4
    ),
    (
        'Blanditiis saepe dolorem enim eos sed ea.',
        1,
        2
    ),
    ('Ab veritatis est.', 2, 2),
    ('Vitae voluptatem voluptates vel nam.', 3, 1),
    (
        'Neque aspernatur est non ad vitae nisi ut nobis enim.',
        4,
        3
    ),
    ('Debitis ut amet.', 4, 2),
    (
        'Pariatur beatae nihil cum molestiae provident vel.',
        4,
        4
    ),
    ('Aperiam sunt aliquam illum impedit.', 1, 4),
    (
        'Aut laudantium necessitatibus harum eaque.',
        5,
        3
    ),
    (
        'Debitis voluptatum nesciunt quisquam voluptatibus fugiat nostrum sed dolore quasi.',
        3,
        2
    ),
    (
        'Praesentium velit voluptatem distinctio ut voluptatum at aut.',
        2,
        2
    ),
    (
        'Voluptates nihil voluptatum quia maiores dolorum molestias occaecati.',
        1,
        4
    ),
    ('Quisquam modi labore.', 3, 2),
    (
        'Fugit quia perferendis magni doloremque dicta officia dignissimos ut necessitatibus.',
        1,
        4
    ),
    (
        'Tempora ipsam aut placeat ducimus ut exercitationem quis provident.',
        5,
        3
    ),
    ('Expedita ducimus cum quibusdam.', 5, 1),
    (
        'In voluptates doloribus aut ut libero possimus adipisci iste.',
        3,
        2
    ),
    (
        'Sit qui est sed accusantium quidem id voluptatum id.',
        1,
        5
    ),
    (
        'Libero eius quo consequatur laudantium reiciendis reiciendis aliquid nemo.',
        1,
        2
    ),
    (
        'Officia qui reprehenderit ut accusamus qui voluptatum at.',
        2,
        2
    ),
    ('Ad similique quo.', 4, 1),
    (
        'Commodi culpa aut nobis qui illum deserunt reiciendis.',
        2,
        3
    ),
    (
        'Tenetur quam aut rerum doloribus est ipsa autem.',
        4,
        2
    ),
    (
        'Est accusamus aut nisi sit aut id non natus assumenda.',
        2,
        4
    ),
    ('Et sit et vel quos recusandae quo qui.', 1, 3),
    ('Velit nihil voluptatem et sed.', 4, 4),
    ('Sunt vitae expedita fugiat occaecati.', 1, 3),
    ('Consequatur quod et ipsam in dolorem.', 4, 2),
    (
        'Magnam voluptatum molestias vitae voluptatibus beatae nostrum sunt.',
        3,
        5
    ),
    (
        'Alias praesentium ut voluptatem alias praesentium tempora voluptas debitis.',
        2,
        5
    ),
    (
        'Ipsam cumque aut consectetur mollitia vel quod voluptates provident suscipit.',
        3,
        5
    ),
    (
        'Ad dignissimos quia aut commodi vel ut nisi.',
        3,
        3
    ),
    (
        'Fugit ut architecto doloremque neque quis.',
        4,
        5
    ),
    (
        'Repudiandae et voluptas aut in excepturi.',
        5,
        3
    ),
    ('Aperiam voluptatem animi.', 5, 1),
    ('Et mollitia vel soluta fugiat.', 4, 1),
    ('Ut nemo voluptas voluptatem voluptas.', 5, 2),
    ('At aut quidem voluptatibus rem.', 5, 1),
    (
        'Temporibus voluptates iure fuga alias minus eius.',
        2,
        3
    ),
    (
        'Non autem laboriosam consectetur officiis aut excepturi nobis commodi.',
        4,
        3
    ),
    (
        'Esse voluptatem sed deserunt ipsum eaque maxime rerum qui.',
        5,
        5
    ),
    (
        'Debitis ipsam ut pariatur molestiae ut qui aut reiciendis.',
        4,
        4
    ),
    (
        'Illo atque nihil et quod consequatur neque pariatur delectus.',
        3,
        3
    ),
    (
        'Qui et hic accusantium odio quis necessitatibus et magni.',
        4,
        2
    ),
    (
        'Debitis repellendus inventore omnis est facere aliquam.',
        3,
        3
    ),
    (
        'Occaecati eos possimus deleniti itaque aliquam accusamus.',
        3,
        4
    ),
    (
        'Molestiae officia architecto eius nesciunt.',
        5,
        4
    ),
    (
        'Minima dolorem reiciendis excepturi culpa sapiente eos deserunt ut.',
        3,
        3
    );

-- three-way join example
SELECT
    url,
    contents,
    username
FROM
    comments
    JOIN photos ON comments.photo_id = photos.id
    JOIN users ON comments.user_id = users.id
    AND photos.user_id = users.id;

-- url	contents	username
-- http://chet.net	Non est totam.	Frederique_Donnelly
-- https://kailyn.name	Fuga et iste beatae.	Alfredo66
-- http://chet.net	Nihil quo voluptatem placeat.	Frederique_Donnelly
-- https://alayna.net	Rerum dolor sunt sint.	Frederique_Donnelly
-- http://marjolaine.name	Culpa perferendis qui perferendis eligendi officia neque ex.	Reyna.Marvin
-- http://marjolaine.name	Enim doloremque delectus.	Reyna.Marvin
-- https://santina.net	Quia dolorem officia explicabo quae.	Alfredo66
-- https://santina.net	Tempora quas facere.	Alfredo66
-- http://chet.net	Rem autem corporis earum necessitatibus dolores explicabo iste quo.	Frederique_Donnelly
-- https://kailyn.name	Porro illum perferendis nemo libero voluptatibus vel.	Alfredo66
-- https://santina.net	Eum aut magni sint.	Alfredo66
-- https://santina.net	Vitae voluptatem voluptates vel nam.	Alfredo66
-- http://marjolaine.name	Aperiam sunt aliquam illum impedit.	Reyna.Marvin
-- http://marjolaine.name	Voluptates nihil voluptatum quia maiores dolorum molestias occaecati.	Reyna.Marvin
-- http://marjolaine.name	Fugit quia perferendis magni doloremque dicta officia dignissimos ut necessitatibus.	Reyna.Marvin
-- https://kailyn.name	Ad dignissimos quia aut commodi vel ut nisi.	Alfredo66
-- https://alayna.net	Ut nemo voluptas voluptatem voluptas.	Frederique_Donnelly
-- http://chet.net	Esse voluptatem sed deserunt ipsum eaque maxime rerum qui.	Frederique_Donnelly
-- https://kailyn.name	Illo atque nihil et quod consequatur neque pariatur delectus.	Alfredo66
-- https://kailyn.name	Debitis repellendus inventore omnis est facere aliquam.	Alfredo66
-- https://kailyn.name	Minima dolorem reiciendis excepturi culpa sapiente eos deserunt ut.	Alfredo66
-- output:
-- url                     | username            | contents
-- ----------------------- | --------------------|-------------------
-- http://chet.net         | Frederique_Donnelly | Non est totam.
-- https://kailyn.name     | Alfredo66           | Fuga et iste beatae.
-- http://chet.net         | Frederique_Donnelly | Nihil quo voluptatem placeat
-- https://alayna.net      | Frederique_Donnelly | Rerum dolor sunt sint.
-- http://marjolaine.name  | Reyna.Marvin        | Culpa perferendis qui perferendis eligendi officia neque ex.
-- http://marjolaine.name  | Reyna.Marvin        | Enim doloremque delectus.
-- https://santina.net     | Alfredo66           | Quia dolorem officia explicabo quae.
-- https://santina.net     | Alfredo66           | Tempora quas facere.
-- http://chet.net         | Frederique_Donnelly | Rem autem corporis earum necessitatibus dolores explicabo iste quo.
-- https://kailyn.name     | Alfredo66           | Porro illum perferendis nemo libero voluptatibus vel.
-- https://santina.net     | Alfredo66           | Eum aut magni sint.
-- https://santina.net     | Alfredo66           | Vitae voluptatem voluptates vel nam.
-- http://marjolaine.name  | Reyna.Marvin        | Aperiam sunt aliquam illum impedit.
-- http://marjolaine.name  | Reyna.Marvin        | Voluptates nihil voluptatum quia maiores dolorum molestias occaecati.
-- http://marjolaine.name  | Reyna.Marvin        | Fugit quia perferendis magni doloremque dicta officia dignissimos ut necessitatibus.
-- https://kailyn.name     | Alfredo66           | Ad dignissimos quia aut commodi vel ut nisi.
-- https://alayna.net      | Frederique_Donnelly | Ut nemo voluptas voluptatem voluptas
-- http://chet.net         | Frederique_Donnelly | Esse voluptatem sed deserunt ipsum eaque maxime rerum qui.
-- https://kailyn.name     | Alfredo66           | Illo atque nihil et quod consequatur neque pariatur delectus.
-- https://kailyn.name     | Alfredo66           | Debitis repellendus inventore omnis est facere aliquam.
-- https://kailyn.name     | Alfredo66           | Minima dolorem reiciendis excepturi culpa sapiente eos deserunt ut.
-- generate sql to add these tables to a database
-- Table of authors
--     +----+-----------------+
--     | id | name            |
--     +----+-----------------+
--     | 1  | Stephen King    |
--     +----+-----------------+
--     | 2  | Agatha Christie |
--     +----+-----------------+
--     | 3  | JK Rowling      |
--     +----+-----------------+
-- Table of books
--     +----+---------------------+-----------+
--     | id | title               | author_id |
--     +----+---------------------+-----------+
--     | 1  | The Dark Tower      | 1         |
--     +----+---------------------+-----------+
--     | 2  | Affair At Styles    | 2         |
--     +----+---------------------+-----------+
--     | 3  | Chamber of Secrets  | 3         |
--     +----+---------------------+-----------+
-- Table of reviews
--     +----+--------+-------------+---------+
--     | id | rating | reviewer_id | book_id |
--     +----+--------+-------------+---------+
--     | 1  | 3      | 1           | 2       |
--     +----+--------+-------------+---------+
--     | 2  | 4      | 2           | 1       |
--     +----+--------+-------------+---------+
--     | 3  | 5      | 3           | 3       |
--     +----+--------+-------------+---------+
CREATE TABLE authors (
    id serial PRIMARY KEY,
    name varchar(100) NOT NULL
);

CREATE TABLE books (
    id serial PRIMARY KEY,
    title varchar(200) NOT NULL,
    author_id integer REFERENCES authors(id) ON DELETE CASCADE
);

CREATE TABLE reviews (
    id serial PRIMARY KEY,
    rating integer NOT NULL CHECK (
        rating >= 1
        AND rating <= 5
    ),
    reviewer_id integer REFERENCES authors(id) ON DELETE CASCADE,
    book_id integer REFERENCES books(id) ON DELETE CASCADE
);

INSERT INTO
    authors (name)
VALUES
    ('Stephen King'),
    ('Agatha Christie'),
    ('JK Rowling');

INSERT INTO
    books (title, author_id)
VALUES
    ('The Dark Tower', 1),
    ('Affair At Styles', 2),
    ('Chamber of Secrets', 3);

INSERT INTO
    reviews (rating, reviewer_id, book_id)
VALUES
    (3, 1, 2),
    (4, 2, 1),
    (5, 3, 3);

SELECT
    title,
    name,
    rating
FROM
    reviews
    JOIN books ON books.id = reviews.book_id
    JOIN authors ON authors.id = books.author_id
    AND books.author_id = authors.id;