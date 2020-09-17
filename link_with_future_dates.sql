-- link with dates in the future
-- 2020-04: 68
-- 2020-05-20: 53
-- 2020-09-17: 9


WITH
link AS (
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
        OR l.end_date_year > 2025
)
SELECT
    link.begin,
    link.end,
    link.entity_type0,
    l_.entity0,
    link.entity_type1,
    l_.entity1
FROM
    link
    INNER JOIN (
        SELECT link, entity0, entity1 FROM l_recording_work
        UNION ALL
        SELECT link, entity0, entity1 FROM l_area_recording
        UNION ALL
        SELECT link, entity0, entity1 FROM l_area_release
        UNION ALL
        SELECT link, entity0, entity1 FROM l_artist_recording
        UNION ALL
        SELECT link, entity0, entity1 FROM l_artist_label
        UNION ALL
        SELECT link, entity0, entity1 FROM l_artist_release_group
        UNION ALL
        SELECT link, entity0, entity1 FROM l_artist_artist
        UNION ALL
        SELECT link, entity0, entity1 FROM l_label_recording
        UNION ALL
        SELECT link, entity0, entity1 FROM l_place_recording
    ) AS l_ ON l_.link = link.id
