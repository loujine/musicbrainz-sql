-- Missing date on performing Artist xor Work relationship

-- pianists
-- 2020-04: 1597
-- 2020-05-20: 1584
-- 2020-09-16: 1062
-- 2021-01-13: 1001
-- 2021-11-07: 725

SELECT DISTINCT
    a.sort_name AS artist_name,
    to_recording_url(r.gid) AS recording_url,
    SUBSTRING(r.name for 50) AS recording_name
FROM
    recording               AS r
    INNER JOIN l_artist_recording AS lar ON r.id = lar.entity1
    INNER JOIN pianist            AS a   ON a.id = lar.entity0
    INNER JOIN link               AS lia ON lia.id = lar.link
    INNER JOIN link_type          AS lt  ON lt.id = lia.link_type
    INNER JOIN l_recording_work   AS lrw ON r.id = lrw.entity0
    INNER JOIN work               AS w   ON w.id = lrw.entity1
    INNER JOIN link               AS liw ON liw.id = lrw.link
WHERE
    lt.name = 'instrument'
    AND ((lia.begin_date_year IS NOT NULL AND liw.begin_date_year IS NULL)
         OR (lia.begin_date_year IS NULL AND liw.begin_date_year IS NOT NULL))
ORDER BY
    artist_name,
    recording_name,
    recording_url
;

-- violinist
-- 2020-05-20: 30
-- 2020-09-16: 12
-- 2021-01-13: 14
-- 2021-11-07: 215

SELECT DISTINCT
    a.sort_name AS artist_name,
    to_recording_url(r.gid) AS recording_url,
    SUBSTRING(r.name for 50) AS recording_name
FROM
    recording               AS r
    INNER JOIN l_artist_recording AS lar ON r.id = lar.entity1
    INNER JOIN violinist          AS a   ON a.id = lar.entity0
    INNER JOIN link               AS lia ON lia.id = lar.link
    INNER JOIN link_type          AS lt  ON lt.id = lia.link_type
    INNER JOIN l_recording_work   AS lrw ON r.id = lrw.entity0
    INNER JOIN work               AS w   ON w.id = lrw.entity1
    INNER JOIN link               AS liw ON liw.id = lrw.link
WHERE
    lt.name = 'instrument'
    AND ((lia.begin_date_year IS NOT NULL AND liw.begin_date_year IS NULL)
         OR (lia.begin_date_year IS NULL AND liw.begin_date_year IS NOT NULL))
ORDER BY
    artist_name,
    recording_name,
    recording_url
;

-- quartet
-- 2020-05-20: 175
-- 2020-09-16: 25
-- 2021-01-13: 14
-- 2021-11-07: 10

SELECT DISTINCT
    a.sort_name AS artist_name,
    to_recording_url(r.gid) AS recording_url,
    SUBSTRING(r.name for 50) AS recording_name
FROM
    recording               AS r
    INNER JOIN l_artist_recording AS lar ON r.id = lar.entity1
    INNER JOIN quartet            AS a   ON a.id = lar.entity0
    INNER JOIN link               AS lia ON lia.id = lar.link
    INNER JOIN link_type          AS lt  ON lt.id = lia.link_type
    INNER JOIN l_recording_work   AS lrw ON r.id = lrw.entity0
    INNER JOIN work               AS w   ON w.id = lrw.entity1
    INNER JOIN link               AS liw ON liw.id = lrw.link
WHERE
    lt.name = 'instrument'
    AND ((lia.begin_date_year IS NOT NULL AND liw.begin_date_year IS NULL)
         OR (lia.begin_date_year IS NULL AND liw.begin_date_year IS NOT NULL))
ORDER BY
    artist_name,
    recording_name,
    recording_url
;

-- conductor
-- 2020-05-20: 1293
-- 2020-09-16: 807
-- 2021-01-13: 1370
-- 2021-11-07: 951

SELECT DISTINCT
    a.sort_name AS artist_name,
    to_recording_url(r.gid) AS recording_url,
    SUBSTRING(r.name for 50) AS recording_name
FROM
    recording               AS r
    INNER JOIN l_artist_recording AS lar ON r.id = lar.entity1
    INNER JOIN conductor          AS a   ON a.id = lar.entity0
    INNER JOIN link               AS lia ON lia.id = lar.link
    INNER JOIN link_type          AS lt  ON lt.id = lia.link_type
    INNER JOIN l_recording_work   AS lrw ON r.id = lrw.entity0
    INNER JOIN work               AS w   ON w.id = lrw.entity1
    INNER JOIN link               AS liw ON liw.id = lrw.link
WHERE
    lt.name = 'conductor'
    AND ((lia.begin_date_year IS NOT NULL AND liw.begin_date_year IS NULL)
         OR (lia.begin_date_year IS NULL AND liw.begin_date_year IS NOT NULL))
ORDER BY
    artist_name,
    recording_name,
    recording_url
;
