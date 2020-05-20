-- missing date on performer xor work relationship on pianists recordings

-- pianists
-- 2020-04: 1597
-- 2020-05-20: 1584

-- violinist
-- 2020-05-20: 30

-- quartet
-- 2020-05-20: 175

-- conductor
-- 2020-05-20: 1293

SELECT
    to_recording_url(r.gid) AS recording_url,
    SUBSTRING(r.name for 50) AS recording_name
FROM
    recording               AS r
    INNER JOIN l_artist_recording AS lar ON r.id = lar.entity1
    /* INNER JOIN pianist            AS a   ON a.id = lar.entity0 */
    /* INNER JOIN violinist          AS a   ON a.id = lar.entity0 */
    /* INNER JOIN quartet            AS a   ON a.id = lar.entity0 */
    INNER JOIN conductor          AS a   ON a.id = lar.entity0
    INNER JOIN link               AS lia ON lia.id = lar.link
    INNER JOIN l_recording_work   AS lrw ON r.id = lrw.entity0
    INNER JOIN work               AS w   ON w.id = lrw.entity1
    INNER JOIN link               AS liw ON liw.id = lrw.link
WHERE
    (lia.begin_date_year IS NOT NULL AND liw.begin_date_year IS NULL)
    OR (lia.begin_date_year IS NULL AND liw.begin_date_year IS NOT NULL)
