-- Composers as recording artist

SELECT
    a.sort_name,
    COUNT(*) AS cnt
FROM
    artist_credit_name AS acn
    INNER JOIN recording AS r USING(artist_credit)
    INNER JOIN composer AS a ON a.id = acn.artist
GROUP BY
    a.id,
    a.sort_name
ORDER BY
    cnt DESC
;


-- Composers as recording artist, no related work

SELECT
    a.sort_name,
    COUNT(*) AS cnt
FROM
    artist_credit_name AS acn
    INNER JOIN recording AS r USING(artist_credit)
    INNER JOIN composer AS a ON a.id = acn.artist
    LEFT OUTER JOIN l_recording_work AS lrw ON r.id = lrw.entity0
WHERE
    lrw.entity0 IS NULL
GROUP BY
    a.id,
    a.sort_name
ORDER BY
    cnt DESC
;


-- Composers as recording artist and performer relationship

SELECT
    a.sort_name,
    COUNT(*) AS cnt
FROM
    artist_credit_name AS acn
    INNER JOIN recording AS r USING(artist_credit)
    INNER JOIN composer AS a ON a.id = acn.artist
    INNER JOIN l_artist_recording AS lar ON lar.entity0 = a.id
WHERE
    lar.entity1 = r.id
GROUP BY
    a.id,
    a.sort_name
ORDER BY
    cnt DESC
;


-- Composers as recording artist and composer is not performing (Debussy, etc.)

WITH
composer_wo_performer AS (
    SELECT
        a.sort_name,
        r.gid
    FROM
        artist_credit_name AS acn
        INNER JOIN recording AS r USING(artist_credit)
        INNER JOIN composer AS a ON a.id = acn.artist
    EXCEPT (
        SELECT
            a.sort_name,
            r.gid
        FROM
            artist_credit_name AS acn
            INNER JOIN recording AS r USING(artist_credit)
            INNER JOIN composer AS a ON a.id = acn.artist
            INNER JOIN l_artist_recording AS lar ON lar.entity0 = a.id
        WHERE
            lar.entity1 = r.id
    )
)
SELECT
    sort_name,
    COUNT(*) AS cnt
FROM
    composer_wo_performer
GROUP BY
    sort_name
ORDER BY
    cnt DESC
;
