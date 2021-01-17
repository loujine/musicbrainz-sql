-- Recording names that contain words very close to 'andante'
-- can help catching typos

WITH
results AS (
    SELECT
        gid,
        LEVENSHTEIN_LESS_EQUAL(
            /* 'andante', */
            'adagio',
            REGEXP_SPLIT_TO_TABLE(LOWER(SUBSTRING(name for 255)), '[\s:;.,()\[\]"]+'),
            3) AS distance,
        name
    FROM recording
    LIMIT 10000000
)
SELECT
    to_recording_url(gid),
    SUBSTRING(name for 60),
    distance
FROM
    results
WHERE
    distance BETWEEN 1 AND 2
ORDER BY
    name
