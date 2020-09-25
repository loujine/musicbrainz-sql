-- works with 'major' or 'minor' in title, without composer without recording
-- 2020-04: 43
-- 2020-05-20: 44
-- 2020-09-16: 33

SELECT
    to_md(to_work_url(w.gid)) AS work_url,
    w.name AS work_name
FROM
    work AS w
    LEFT OUTER JOIN l_recording_work AS lrw ON w.id = lrw.entity1
    LEFT OUTER JOIN l_artist_work    AS law ON w.id = law.entity1
    /* LEFT OUTER JOIN l_work_work      AS lww ON w.id = lww.entity1 */
WHERE
    law.entity1 IS NULL
    AND lrw.entity1 IS NULL
    /* AND (lww.entity1 IS NULL OR lww.entity0 IS NULL) */
    AND (w.name LIKE '%major%' OR w.name LIKE '%minor%')
ORDER BY
    work_name,
    work_url
