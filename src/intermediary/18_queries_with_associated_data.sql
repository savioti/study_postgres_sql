SELECT
    *
FROM
    photos
WHERE
    -- user_id is a foreign key referencing the users table
    user_id = 1;

SELECT
    url,
    username
FROM
    photos
    JOIN users ON photos.user_id = users.id