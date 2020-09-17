-- main works without imslp links

-- 2020-04 : 532
-- 2020-09-16: 500

SELECT
    to_work_url(w.gid) AS work_url,
    w.name AS work_name
FROM
    work               AS w
    INNER JOIN l_artist_work AS law ON w.id = law.entity1
    INNER JOIN composer      AS a   ON a.id = law.entity0
    INNER JOIN link          AS l   ON l.id = law.link
    INNER JOIN link_type     AS lt  ON lt.id = l.link_type
WHERE
    (a.name = 'Ludwig van Beethoven' OR a.name = 'Claude Debussy')
    AND lt.name = 'composer'
    /* AND w.name like '%WoO%' */
EXCEPT (
    -- arrangements, parts, etc.
    SELECT
        to_work_url(w.gid) AS work_url,
        w.name AS work_name
    FROM
        work             AS w
        INNER JOIN l_work_work AS lww ON w.id = lww.entity1
    )
EXCEPT (
    -- already linked to imslp
    SELECT
        to_work_url(w.gid) AS work_url,
        w.name AS work_name
    FROM
        work            AS w
        INNER JOIN l_url_work AS luw ON w.id = luw.entity1
        INNER JOIN url        AS u   ON u.id = luw.entity0
    WHERE
        url ILIKE '%imslp%'
    )
ORDER BY
    work_name
