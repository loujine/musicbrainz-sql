-- works with ordered movements
-- 2020-09-16: 8244

WITH tmp AS (
SELECT
    w.gid,
    w.name
FROM
    work                   AS w
    INNER JOIN l_work_work AS lww ON w.id = lww.entity0
    INNER JOIN work        AS sw  ON sw.id = lww.entity1
    INNER JOIN link        AS li  ON li.id = lww.link
    INNER JOIN link_type   AS lt  ON lt.id = li.link_type
    INNER JOIN link_attribute AS la ON lww.link = la.link
    INNER JOIN link_attribute_type AS lat ON lat.id = la.attribute_type
WHERE
    lt.name = 'parts'
    AND lat.name = 'movement'
    AND lww.link_order != 0
)
SELECT
    to_md(to_work_url(gid)),
    name,
    COUNT(gid) AS nb_mvmts
FROM
    tmp
GROUP BY
    gid, name
ORDER BY
    COUNT(gid) DESC;
