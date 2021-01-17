-- releases with "feat." in title

-- 2020-04: 239
-- 2020-05-20: 237
-- 2020-09-16: 216

WITH
results AS (
    SELECT
        r.gid,
        r.name
    FROM
        artist_credit_name AS acn
        INNER JOIN composer AS a ON a.id = acn.artist
        INNER JOIN release AS r ON r.artist_credit = acn.artist_credit
)
SELECT
    to_release_url(r.gid) AS release_url,
    r.name AS release_name
FROM
    results AS r
WHERE
    r.name ILIKE '%feat.%'
ORDER BY
    release_name, release_url
