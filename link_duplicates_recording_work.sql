-- duplicate relationships between work and recording (filtered on main composers)

WITH
results AS (
    SELECT
        work.gid AS wmbid,
        r.gid AS rmbid,
        r.name
    FROM
        composer
        /* artist AS composer */
        INNER JOIN l_artist_work AS law ON composer.id = entity0
        INNER JOIN work ON work.id = entity1
        INNER JOIN l_recording_work AS lrw ON work.id = lrw.entity1
        INNER JOIN recording AS r ON r.id = lrw.entity0
    /* WHERE */
    /*     composer.begin_date_year < 1900 */
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
