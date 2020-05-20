-- recordings out of avg +- 1.5stddev durations
-- TODO check stddev_samp, stddev_pop

WITH
rec AS (
    SELECT
        w.gid AS wmbid,
        r.gid,
        r.name,
        r.length
    FROM
        work             AS w
        INNER JOIN l_recording_work AS lar ON lar.entity1 = w.id
        INNER JOIN recording        AS r   ON r.id = lar.entity0
        INNER JOIN link             AS l   ON lar.link = l.id
        INNER JOIN link_attribute   AS la  ON l.id = la.link
    WHERE
        w.gid = 'cf315953-a2bf-32ec-be4b-0d4bfaf05e97'
        OR w.gid = '4ebf3fc1-4dd4-361b-a441-bf1dc9421e34'
        AND la.attribute_type != 579
),
stats AS (
    SELECT
        rec.wmbid,
        AVG(rec.length) AS avg,
        STDDEV_SAMP(rec.length) AS std
    FROM
        rec
    GROUP BY
        rec.wmbid
)
SELECT
    r.wmbid,
    to_recording_url(r.gid) AS url,
    SUBSTRING(r.name for 50),
    r.length/60000 AS min,
    (r.length/1000)%60 AS sec
FROM
    rec AS r
    INNER JOIN stats ON stats.wmbid = r.wmbid
WHERE
    length NOT BETWEEN avg - 1.5*std AND avg + 1.5*std
ORDER BY
    r.wmbid,
    min,
    sec

-- INSERT INTO recording VALUES();
