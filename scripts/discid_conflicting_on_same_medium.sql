-- medium with distinct discids more than X seconds apart
-- durations are computed on beginning of the last track.
-- Available as "Releases with conflicting disc IDs" report in MBS

-- 2020-09-16: 2061

WITH
mc AS (
    SELECT
        UNNEST(ARRAY_AGG(cdtoc)) AS cdtoc,
        medium
    FROM
        medium_cdtoc
    GROUP BY
        medium
    HAVING
        COUNT(medium) > 1
),
toc AS (
    SELECT
        c.discid,
        c.leadout_offset,
        m.position,
        r.id,
        r.name,
        r.artist_credit
    FROM
        cdtoc AS c
        INNER JOIN mc ON c.id = mc.cdtoc
        INNER JOIN medium AS m ON m.id = mc.medium
        INNER JOIN release AS r ON r.id = m.release
),
results AS (
    SELECT
        MAX(leadout_offset) - MIN(leadout_offset) AS maxdiff,
        id,
        position,
        name,
        artist_credit
    FROM
        toc
    GROUP BY
        id,
        position,
        name,
        artist_credit
    HAVING
        COUNT(discid) > 1
)
SELECT
    id AS release_id,
    position,
    row_number() OVER (ORDER BY artist_credit, name)
FROM
    results
WHERE
    (maxdiff / 75) > (3*60)  -- limit 3min / 180sec
