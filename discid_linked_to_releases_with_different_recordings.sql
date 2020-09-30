-- discids linked to releases where track 1 do not share the same recording
-- track 1 2020-05: 3775
-- track 20 2020-05: 500
-- track 30 2020-05: 95

WITH
toc AS (
    SELECT
        c.id, c.discid
    FROM
        cdtoc AS c
        INNER JOIN medium_cdtoc ON c.id = medium_cdtoc.cdtoc
    /* WHERE */
    /*     c.discid IN ('zij46Tv0uT9b0h4Hqv6IDtvZm7g-', 'zmEYQ49GjtBX_qr.93IOC2P0guE-') */
    GROUP BY
        c.id, c.discid
    HAVING
        COUNT(c.id) > 1
),
results AS (
    SELECT
        toc.discid,
        t.name AS track,
        to_recording_url(r.gid) AS url
    FROM
        toc
        INNER JOIN medium_cdtoc AS mc ON mc.cdtoc = toc.id
        INNER JOIN track AS t ON t.medium = mc.medium
        INNER JOIN recording AS r ON t.recording = r.id
    WHERE
        t.position = 10
    GROUP BY
        toc.discid, t.name, r.gid
)
SELECT
    to_md(to_cdtoc_url(discid)),
    ARRAY_AGG(track) AS track_names
FROM
    results
GROUP BY
    discid
HAVING
    COUNT(DISTINCT(url)) > 1
