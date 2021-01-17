-- find recordings from pianists/etc. where track durations vary a lot

WITH
rec AS (
SELECT
    r.gid,
    a.name AS artist_name,
    r.name,
    t.length
FROM
    l_artist_recording AS lar
    INNER JOIN pianist AS a ON a.id = lar.entity0
    INNER JOIN recording AS r ON r.id = lar.entity1
    INNER JOIN track AS t ON r.id = t.recording
ORDER BY
    r.name
),
stats AS (
SELECT
    gid,
    artist_name,
    name,
    AVG(length) AS avg,
    STDDEV_SAMP(length) AS std
FROM
    rec
GROUP BY
    gid, artist_name, name
)
SELECT
    to_md(to_recording_url(gid)) AS recording_url,
    artist_name,
    SUBSTRING(name for 50) AS recording_name
FROM
    stats
WHERE
    std > 0.1 * avg
ORDER BY
    artist_name,
    recording_name
;

WITH
rec AS (
SELECT
    r.gid,
    a.name AS artist_name,
    r.name,
    t.length
FROM
    l_artist_recording AS lar
    INNER JOIN violinist AS a ON a.id = lar.entity0
    INNER JOIN recording AS r ON r.id = lar.entity1
    INNER JOIN track AS t ON r.id = t.recording
ORDER BY
    r.name
),
stats AS (
SELECT
    gid,
    artist_name,
    name,
    AVG(length) AS avg,
    STDDEV_SAMP(length) AS std
FROM
    rec
GROUP BY
    gid, artist_name, name
)
SELECT
    to_md(to_recording_url(gid)) AS recording_url,
    artist_name,
    SUBSTRING(name for 50) AS recording_name
FROM
    stats
WHERE
    std > 0.1 * avg
ORDER BY
    artist_name,
    recording_name
;

WITH
rec AS (
SELECT
    r.gid,
    a.name AS artist_name,
    r.name,
    t.length
FROM
    l_artist_recording AS lar
    INNER JOIN quartet AS a ON a.id = lar.entity0
    INNER JOIN recording AS r ON r.id = lar.entity1
    INNER JOIN track AS t ON r.id = t.recording
ORDER BY
    r.name
),
stats AS (
SELECT
    gid,
    artist_name,
    name,
    AVG(length) AS avg,
    STDDEV_SAMP(length) AS std
FROM
    rec
GROUP BY
    gid, artist_name, name
)
SELECT
    to_md(to_recording_url(gid)) AS recording_url,
    artist_name,
    SUBSTRING(name for 50) AS recording_name
FROM
    stats
WHERE
    std > 0.1 * avg
ORDER BY
    artist_name,
    recording_name
;

WITH
rec AS (
SELECT
    r.gid,
    a.name AS artist_name,
    r.name,
    t.length
FROM
    l_artist_recording AS lar
    INNER JOIN conductor AS a ON a.id = lar.entity0
    INNER JOIN recording AS r ON r.id = lar.entity1
    INNER JOIN track AS t ON r.id = t.recording
ORDER BY
    r.name
),
stats AS (
SELECT
    gid,
    artist_name,
    name,
    AVG(length) AS avg,
    STDDEV_SAMP(length) AS std
FROM
    rec
GROUP BY
    gid, artist_name, name
)
SELECT
    to_md(to_recording_url(gid)) AS recording_url,
    artist_name,
    SUBSTRING(name for 50) AS recording_name
FROM
    stats
WHERE
    std > 0.1 * avg
ORDER BY
    artist_name,
    recording_name
;
