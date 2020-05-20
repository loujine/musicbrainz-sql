-- link with dates in the future
-- 2020-04: 68
-- 2020-05-20: 53


WITH
l AS (
    SELECT
        l.id,
        l.begin_date_year AS begin,
        l.end_date_year AS end,
        lt.entity_type0,
        lt.entity_type1
    FROM
        link AS l
        INNER JOIN link_type AS lt ON lt.id = l.link_type
    WHERE
        l.begin_date_year > 2020
        OR l.end_date_year > 2030
)
SELECT
    l.begin,
    l.end,
    l.entity_type0,
    l.entity_type1,
    to_recording_url(e.gid)
FROM
    l
    INNER JOIN l_recording_work AS lar ON lar.link = l.id
    INNER JOIN recording AS e ON e.id = lar.entity0
UNION
SELECT
    l.begin,
    l.end,
    l.entity_type0,
    l.entity_type1,
    to_recording_url(e.gid)
FROM
    l
    INNER JOIN l_area_recording AS lar ON lar.link = l.id
    INNER JOIN recording AS e ON e.id = lar.entity1
UNION
SELECT
    l.begin,
    l.end,
    l.entity_type0,
    l.entity_type1,
    to_release_url(e.gid)
FROM
    l
    INNER JOIN l_area_release AS lar ON lar.link = l.id
    INNER JOIN release AS e ON e.id = lar.entity1
UNION
SELECT
    l.begin,
    l.end,
    l.entity_type0,
    l.entity_type1,
    to_recording_url(e.gid)
FROM
    l
    INNER JOIN l_artist_recording AS lar ON lar.link = l.id
    INNER JOIN recording AS e ON e.id = lar.entity1
UNION
SELECT
    l.begin,
    l.end,
    l.entity_type0,
    l.entity_type1,
    to_label_url(e.gid)
FROM
    l
    INNER JOIN l_artist_label AS lal ON lal.link = l.id
    INNER JOIN label AS e ON e.id = lal.entity1
UNION
SELECT
    l.begin,
    l.end,
    l.entity_type0,
    l.entity_type1,
    to_release_group_url(e.gid)
FROM
    l
    INNER JOIN l_artist_release_group AS larr ON larr.link = l.id
    INNER JOIN release_group AS e ON e.id = larr.entity1
UNION
SELECT
    l.begin,
    l.end,
    l.entity_type0,
    l.entity_type1,
    to_artist_url(e.gid)
FROM
    l
    INNER JOIN l_artist_artist AS laa ON laa.link = l.id
    INNER JOIN artist AS e ON e.id = laa.entity0
UNION
SELECT
    l.begin,
    l.end,
    l.entity_type0,
    l.entity_type1,
    to_recording_url(e.gid)
FROM
    l
    INNER JOIN l_label_recording AS llr ON llr.link = l.id
    INNER JOIN recording AS e ON e.id = llr.entity1
UNION
SELECT
    l.begin,
    l.end,
    l.entity_type0,
    l.entity_type1,
    to_recording_url(e.gid)
FROM
    l
    INNER JOIN l_place_recording AS lpr ON lpr.link = l.id
    INNER JOIN recording AS e ON e.id = lpr.entity1
