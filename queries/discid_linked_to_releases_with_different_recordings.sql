-- discids linked to releases where track 20 do not share the same recording
-- track 1 2020-05: 3775
-- track 20 2020-05: 500
-- track 30 2020-05: 95
-- track 8 2021-01-13: 3009

WITH
toc AS (
    SELECT
        c.id, c.discid
    FROM
        cdtoc AS c
        INNER JOIN medium_cdtoc ON c.id = medium_cdtoc.cdtoc
    GROUP BY
        c.id, c.discid
    HAVING
        COUNT(c.id) > 1
),
results AS (
    SELECT
        toc.discid,
        t.name AS track,
        a.sort_name AS name,
        to_recording_url(r.gid) AS url
    FROM
        toc
        INNER JOIN medium_cdtoc AS mc ON mc.cdtoc = toc.id
        INNER JOIN track AS t ON t.medium = mc.medium
        INNER JOIN recording AS r ON t.recording = r.id
        INNER JOIN l_artist_recording AS lar ON lar.entity1 = r.id
        INNER JOIN pianist AS a ON lar.entity0 = a.id
    WHERE
        t.position = 6
    GROUP BY
        toc.discid, t.name, a.sort_name, r.gid
)
SELECT
    to_cdtoc_url(discid) AS discid,
    ARRAY_AGG(track) AS track_names
FROM
    results
GROUP BY
    discid
HAVING
    COUNT(DISTINCT(url)) > 1
;

WITH
toc AS (
    SELECT
        c.id, c.discid
    FROM
        cdtoc AS c
        INNER JOIN medium_cdtoc ON c.id = medium_cdtoc.cdtoc
    GROUP BY
        c.id, c.discid
    HAVING
        COUNT(c.id) > 1
),
results AS (
    SELECT
        toc.discid,
        t.name AS track,
        a.sort_name AS name,
        to_recording_url(r.gid) AS url
    FROM
        toc
        INNER JOIN medium_cdtoc AS mc ON mc.cdtoc = toc.id
        INNER JOIN track AS t ON t.medium = mc.medium
        INNER JOIN recording AS r ON t.recording = r.id
        INNER JOIN l_artist_recording AS lar ON lar.entity1 = r.id
        INNER JOIN violinist AS a ON lar.entity0 = a.id
    WHERE
        t.position = 6
    GROUP BY
        toc.discid, t.name, a.sort_name, r.gid
)
SELECT
    to_cdtoc_url(discid) AS discid,
    ARRAY_AGG(track) AS track_names
FROM
    results
GROUP BY
    discid
HAVING
    COUNT(DISTINCT(url)) > 1
;

WITH
toc AS (
    SELECT
        c.id, c.discid
    FROM
        cdtoc AS c
        INNER JOIN medium_cdtoc ON c.id = medium_cdtoc.cdtoc
    GROUP BY
        c.id, c.discid
    HAVING
        COUNT(c.id) > 1
),
results AS (
    SELECT
        toc.discid,
        t.name AS track,
        a.sort_name AS name,
        to_recording_url(r.gid) AS url
    FROM
        toc
        INNER JOIN medium_cdtoc AS mc ON mc.cdtoc = toc.id
        INNER JOIN track AS t ON t.medium = mc.medium
        INNER JOIN recording AS r ON t.recording = r.id
        INNER JOIN l_artist_recording AS lar ON lar.entity1 = r.id
        INNER JOIN quartet AS a ON lar.entity0 = a.id
    WHERE
        t.position = 6
    GROUP BY
        toc.discid, t.name, a.sort_name, r.gid
)
SELECT
    to_cdtoc_url(discid) AS discid,
    ARRAY_AGG(track) AS track_names
FROM
    results
GROUP BY
    discid
HAVING
    COUNT(DISTINCT(url)) > 1
;

WITH
toc AS (
    SELECT
        c.id, c.discid
    FROM
        cdtoc AS c
        INNER JOIN medium_cdtoc ON c.id = medium_cdtoc.cdtoc
    GROUP BY
        c.id, c.discid
    HAVING
        COUNT(c.id) > 1
),
results AS (
    SELECT
        toc.discid,
        t.name AS track,
        a.sort_name AS name,
        to_recording_url(r.gid) AS url
    FROM
        toc
        INNER JOIN medium_cdtoc AS mc ON mc.cdtoc = toc.id
        INNER JOIN track AS t ON t.medium = mc.medium
        INNER JOIN recording AS r ON t.recording = r.id
        INNER JOIN l_artist_recording AS lar ON lar.entity1 = r.id
        INNER JOIN conductor AS a ON lar.entity0 = a.id
    WHERE
        t.position = 6
    GROUP BY
        toc.discid, t.name, a.sort_name, r.gid
)
SELECT
    to_cdtoc_url(discid) AS discid,
    ARRAY_AGG(track) AS track_names
FROM
    results
GROUP BY
    discid
HAVING
    COUNT(DISTINCT(url)) > 1
;
