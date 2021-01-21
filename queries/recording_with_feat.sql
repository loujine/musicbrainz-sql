-- recordings with "feat." in title
-- 2020-04: 642
-- 2020-05-20: 643
-- 2020-09-16: 626

WITH
    results
AS (
    SELECT
        r.gid,
        r.name
    FROM
        composer
        INNER JOIN l_artist_work AS law ON composer.id = entity0
        INNER JOIN work ON work.id = entity1
        INNER JOIN l_recording_work AS lrw ON work.id = lrw.entity1
        INNER JOIN recording AS r ON r.id = lrw.entity0
)
SELECT
    to_recording_url(r.gid) AS recording_url,
    r.name AS recording_name
FROM
    results AS r
WHERE
    r.name ILIKE '%feat.%'
ORDER BY
    recording_name, recording_url
