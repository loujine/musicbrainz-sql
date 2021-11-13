-- duplicate relationships (>= 4) between work and recording (filtered on main composers)

-- >=4
-- 2020-09-16: 41
-- 2021-10-16: 55
-- 2021-11-07: 0

WITH
composer_work AS (
    SELECT DISTINCT
        work.id,
        work.gid
    FROM
        composer
        INNER JOIN l_artist_work AS law ON composer.id = entity0
        INNER JOIN work ON work.id = entity1
),
results AS (
    SELECT
        composer_work.gid AS wmbid,
        r.gid AS rmbid,
        r.name
    FROM
        composer_work
        INNER JOIN l_recording_work AS lrw ON composer_work.id = lrw.entity1
        INNER JOIN recording AS r ON r.id = lrw.entity0
)
SELECT
    -- to_work_url(wmbid),
    COUNT(*) AS cnt,
    to_recording_url(rmbid),
    SUBSTRING(name for 50)
FROM
    results
GROUP BY
    wmbid,
    rmbid,
    name
HAVING
    COUNT(*) > 3
ORDER BY
    name
