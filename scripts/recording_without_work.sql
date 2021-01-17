-- find recordings from pianists not linked to any work
-- 2020-04-22: 2149
-- 2020-05-20: 2905
-- 2020-09-16: 2318

SELECT
    to_recording_url(r.gid) AS recording_url,
    SUBSTRING(r.name for 50) AS recording_name
FROM
    l_artist_recording AS lar
    INNER JOIN pianist AS a ON a.id = lar.entity0
    INNER JOIN recording AS r ON r.id = lar.entity1
    LEFT OUTER JOIN l_recording_work AS lrw ON r.id = lrw.entity0
WHERE
    lrw.entity0 IS NULL
ORDER BY
    r.name
