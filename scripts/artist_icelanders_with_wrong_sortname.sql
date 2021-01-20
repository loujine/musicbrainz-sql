-- Icelandic artists

-- icelandic artist by type (orchestra/choir/group/person)
-- +-----------+-------+
-- | name      | cnt   |
-- |-----------+-------|
-- | Other     | 1     |
-- | Group     | 474   |
-- | Person    | 1120  |
-- | Character | 1     |
-- | Choir     | 18    |
-- | Orchestra | 6     |
-- +-----------+-------+

WITH RECURSIVE iceland_areas AS (
    SELECT
        id,
        name
    FROM
        area
    WHERE
        name = 'Iceland'
    UNION
        SELECT
            a.id,
            a.name
        FROM
            area AS a
            JOIN l_area_area AS laa ON laa.entity1 = a.id
            JOIN iceland_areas AS aa ON aa.id = laa.entity0
), artists AS (
    SELECT
        artist.type AS type,
        COUNT(*) AS cnt
    FROM
        artist
        JOIN iceland_areas ON artist.area = iceland_areas.id
    GROUP BY
        artist.type
)
SELECT
    artist_type.name,
    artists.cnt
FROM
    artists
    JOIN artist_type ON artists.type = artist_type.id
;



-- Icelandic artists with wrong sort_name
-- 2021-01-13: 69
WITH RECURSIVE iceland_areas AS (
    SELECT
        id,
        name
    FROM
        area
    WHERE
        name = 'Iceland'
    UNION
        SELECT
            a.id,
            a.name
        FROM
            area AS a
            JOIN l_area_area AS laa ON laa.entity1 = a.id
            JOIN iceland_areas AS aa ON aa.id = laa.entity0
)
SELECT
    artist.name,
    artist.sort_name,
    iceland_areas.name AS area,
    to_artist_url(artist.gid) AS artist_url
FROM
    artist
    JOIN iceland_areas ON artist.area = iceland_areas.id
    JOIN artist_type ON artist.type = artist_type.id
WHERE
    artist_type.name = 'Person'
    AND (
        artist.name LIKE '%dóttir'
        OR artist.name LIKE '%son'
    )
    AND artist.sort_name != artist.name
ORDER BY
    artist.name
;


-- Icelandic-looking name to fix
-- 2021-01-13: 9
SELECT
    artist.name,
    area.name AS area,
    birth_area.name AS birth_area,
    to_artist_url(artist.gid) AS artist_url
FROM
    artist
    LEFT OUTER JOIN area ON artist.area = area.id
    LEFT OUTER JOIN area AS birth_area ON artist.begin_area = birth_area.id
WHERE
    artist.name LIKE '%dottir'
;


-- Icelandic-looking name, not from Iceland
-- 2021-01-13: 70
WITH RECURSIVE iceland_areas AS (
    SELECT
        id,
        name
    FROM
        area
    WHERE
        name = 'Iceland'
    UNION
        SELECT
            a.id,
            a.name
        FROM
            area AS a
            JOIN l_area_area AS laa ON laa.entity1 = a.id
            JOIN iceland_areas AS aa ON aa.id = laa.entity0
)
SELECT
    artist.name,
    area.name AS area,
    birth_area.name AS birth_area,
    to_artist_url(artist.gid) AS artist_url
FROM
    artist
    LEFT OUTER JOIN area ON artist.area = area.id
    LEFT OUTER JOIN area AS birth_area ON artist.begin_area = birth_area.id
    JOIN artist_type ON artist.type = artist_type.id
WHERE
    artist.name LIKE '%dóttir'
    AND (area IS NULL OR area.id NOT IN (
        SELECT id FROM iceland_areas
    ))
;


-- Icelandic artists, no artist type set
-- 2020-04-22: 0
WITH RECURSIVE iceland_areas AS (
    SELECT
        id,
        name
    FROM
        area
    WHERE
        name = 'Iceland'
    UNION
        SELECT
            a.id,
            a.name
        FROM
            area AS a
            JOIN l_area_area AS laa ON laa.entity1 = a.id
            JOIN iceland_areas AS aa ON aa.id = laa.entity0
)
SELECT
    COUNT(*) AS cnt
FROM
    artist
    JOIN iceland_areas ON artist.area = iceland_areas.id
WHERE
    artist.type = NULL
;


-- icelanders without birth date
-- 2020-04-22: 124
WITH RECURSIVE iceland_areas AS (
    SELECT
        id,
        name
    FROM
        area
    WHERE
        name = 'Iceland'
    UNION
        SELECT
            a.id,
            a.name
        FROM
            area AS a
            JOIN l_area_area AS laa ON laa.entity1 = a.id
            JOIN iceland_areas AS aa ON aa.id = laa.entity0
)
SELECT
    artist.name,
    to_artist_url(artist.gid) AS artist_url
FROM
    artist
    JOIN iceland_areas ON artist.area = iceland_areas.id
WHERE
    artist.begin_date_year IS NULL
    AND artist.type = 1
ORDER BY
    name
;


-- icelanders born before 1970 without ismus link
-- 2020-04-22: 3
-- 2021-01-20: 5
WITH RECURSIVE iceland_areas AS (
    SELECT
        id,
        name
    FROM
        area
    WHERE
        name = 'Iceland'
    UNION
        SELECT
            a.id,
            a.name
        FROM
            area AS a
            JOIN l_area_area AS laa ON laa.entity1 = a.id
            JOIN iceland_areas AS aa ON aa.id = laa.entity0
)
SELECT
    artist.name,
    to_artist_url(artist.gid) AS artist_url
FROM
    artist
    JOIN iceland_areas ON artist.area = iceland_areas.id
    LEFT OUTER JOIN l_artist_url AS lau ON lau.entity0 = artist.id
WHERE
    artist.begin_date_year < 1970
    AND lau.entity1 IS NULL
;
