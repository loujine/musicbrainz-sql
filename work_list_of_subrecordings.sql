-- split recordings make a whole work

WITH
subworks AS (
    SELECT
        sw.id,
        sw.gid,
        lww.link_order,
        sw.name
    FROM
        work                   AS w
        INNER JOIN l_work_work AS lww ON w.id = lww.entity0
        INNER JOIN work        AS sw  ON sw.id = lww.entity1
        INNER JOIN link        AS li  ON li.id = lww.link
        INNER JOIN link_type   AS lt  ON lt.id = li.link_type
    WHERE
        w.gid = 'f8013df4-d091-4233-ba2e-ed564b3b42b2'
        -- w.gid = '15e0a721-5332-3452-8a56-e00af7b9e4ca'
        AND lt.name = 'parts'
    ORDER BY
        lww.link_order
), number_sw AS (
    SELECT
        COUNT(*) AS cnt
    FROM
        subworks
), recordings AS (
    SELECT
        r.gid,
        li.begin_date_year, -- li.begin_date_month, li.begin_date_day,
        li.end_date_year, -- li.end_date_month, li.end_date_day,
        r.length, ac.name AS artist, r.name
    FROM
        subworks                       AS sw
        INNER JOIN l_recording_work    AS lrw ON lrw.entity1 = sw.id
        INNER JOIN link                AS li  ON li.id = lrw.link
        INNER JOIN recording           AS r   ON r.id = lrw.entity0
        INNER JOIN artist_credit       AS ac  ON ac.id = r.artist_credit
        LEFT OUTER JOIN link_attribute AS la  ON la.link = lrw.link
    WHERE
        li.begin_date_year IS NOT NULL
        AND (la.attribute_type IS NULL OR la.attribute_type != 579)
), stats AS (
    SELECT
        SUBSTRING(r.artist for 50) AS artist,
        r.begin_date_year, -- r.begin_date_month, r.begin_date_day,
        r.end_date_year, -- r.end_date_month, r.end_date_day,
        SUM(r.length) AS total_length,
        ARRAY_AGG(to_recording_url(r.gid)) AS recordings
    FROM
        recordings AS r
    GROUP BY
        r.artist,
        r.begin_date_year, -- r.begin_date_month, r.begin_date_day,
        r.end_date_year -- , r.end_date_month, r.end_date_day
    ORDER BY
        r.artist, r.begin_date_year
)
SELECT
    *
FROM
    stats
    INNER JOIN number_sw ON 1 = 1
WHERE
    CARDINALITY(stats.recordings) = number_sw.cnt
