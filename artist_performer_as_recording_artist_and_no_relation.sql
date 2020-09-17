-- pianist as recording artist but no artist-recording AR at all
-- 2020-04: 2994
-- 2020-05-20: 2257
-- 2020-09-16: 2260

SELECT
    a.sort_name,
    /* COUNT(*) */
    to_recording_url(r.gid)
FROM
    artist_credit_name AS acn
    INNER JOIN pianist      AS a  ON a.id = acn.artist
    INNER JOIN recording    AS r  ON r.artist_credit = acn.artist_credit
    LEFT OUTER JOIN l_artist_recording AS lar ON r.id = lar.entity1
WHERE
    lar.entity0 IS NULL
/* GROUP BY */
/*     a.sort_name */
ORDER BY
    a.sort_name
;


-- conductor as recording artist but no artist-recording AR at all
-- 2020-04: 1892
-- 2020-05-20: 1700
-- 2020-09-16: 1679

SELECT
    a.sort_name,
    to_recording_url(r.gid)
FROM
    artist_credit_name AS acn
    INNER JOIN conductor    AS a  ON a.id = acn.artist
    INNER JOIN recording    AS r  ON r.artist_credit = acn.artist_credit
    LEFT OUTER JOIN l_artist_recording AS lar ON r.id = lar.entity1
WHERE
    lar.entity0 IS NULL
ORDER BY
    a.sort_name
;


-- violinist as recording artist but no artist-recording AR at all
-- 2020-04: 113
-- 2020-05-20: 113
-- 2020-09-16: 102

SELECT
    a.sort_name,
    to_recording_url(r.gid)
FROM
    artist_credit_name AS acn
    INNER JOIN violinist    AS a  ON a.id = acn.artist
    INNER JOIN recording    AS r  ON r.artist_credit = acn.artist_credit
    LEFT OUTER JOIN l_artist_recording AS lar ON r.id = lar.entity1
WHERE
    lar.entity0 IS NULL
ORDER BY
    a.sort_name
;


-- quartet as recording artist but no artist-recording AR at all
-- 2020-04: 1041
-- 2020-05-20: 1114
-- 2020-09-16: 1073

SELECT
    a.sort_name,
    to_recording_url(r.gid)
FROM
    artist_credit_name AS acn
    INNER JOIN quartet      AS a  ON a.id = acn.artist
    INNER JOIN recording    AS r  ON r.artist_credit = acn.artist_credit
    LEFT OUTER JOIN l_artist_recording AS lar ON r.id = lar.entity1
WHERE
    lar.entity0 IS NULL
ORDER BY
    a.sort_name
;
