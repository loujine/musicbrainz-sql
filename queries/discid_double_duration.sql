-- discids attached to the same medium, with vastly different 1st track and total durations

WITH mc AS (
    SELECT
        UNNEST(ARRAY_AGG(cdtoc)) AS cdtoc,
        medium
    FROM
        medium_cdtoc
    GROUP BY
        medium
    HAVING
        COUNT(medium) > 1
), durations AS (
SELECT DISTINCT
    mc.medium,
    track_count,
    cdtoc.discid,
    track_offset[2] - track_offset[1] AS duration,
    leadout_offset
FROM
    mc
    INNER JOIN cdtoc ON mc.cdtoc = cdtoc.id
    INNER JOIN track ON track.medium = mc.medium
ORDER BY
    mc.medium,
    duration
), limits AS (
SELECT
    medium,
    track_count,
    FIRST_VALUE(discid) OVER (PARTITION BY medium ORDER BY duration) AS discmin,
    FIRST_VALUE(duration) OVER (PARTITION BY medium ORDER BY duration) AS min,
    FIRST_VALUE(leadout_offset) OVER (PARTITION BY medium ORDER BY duration) AS endmin,
    LAST_VALUE(discid) OVER (PARTITION BY medium ORDER BY duration) AS discmax,
    LAST_VALUE(duration) OVER (PARTITION BY medium ORDER BY duration) AS max,
    LAST_VALUE(leadout_offset) OVER (PARTITION BY medium ORDER BY duration) AS endmax
FROM
    durations
)
SELECT DISTINCT
    to_release_url(release.gid) AS release_url,
--  track_count AS tracks,
--  endmin,
--  endmax,
    to_cdtoc_url(discmin) AS urlmin,
    to_cdtoc_url(discmax) AS urlmax
FROM
    limits
    INNER JOIN medium ON medium.id = limits.medium
    INNER JOIN release ON release.id = medium.release
WHERE
    ABS(max - 2 * min) < 500
    AND ABS(endmax - 2 * endmin) < 500
-- ORDER BY
--     track_count
;
