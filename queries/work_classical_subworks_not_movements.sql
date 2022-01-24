-- Symphonies/Concertos subworks that have the same type
-- 2022-01-21: 1639

WITH
    composer_work AS (
        SELECT DISTINCT
            work.id,
            work.type
        FROM
            composer
            INNER JOIN l_artist_work AS law ON composer.id = entity0
            INNER JOIN work ON work.id = entity1
    )
SELECT
    to_work_url(sw.gid),
    SUBSTRING(sw.name for 50) AS name
FROM
    composer_work             AS w
    INNER JOIN work_type      AS wt  ON w.type = wt.id
    INNER JOIN l_work_work    AS lww ON w.id = lww.entity0
    INNER JOIN work           AS sw  ON sw.id = lww.entity1
    INNER JOIN link           AS li  ON li.id = lww.link
    INNER JOIN link_type      AS lt  ON lt.id = li.link_type
    INNER JOIN work_type      AS swt ON sw.type = swt.id
WHERE
    wt.name IN ('Concerto', 'Quartet', 'Sonata', 'Symphony')
    AND swt.name IN ('Concerto', 'Quartet', 'Sonata', 'Symphony')
    AND lt.name = 'parts'
ORDER BY
    sw.name
;


-- Symphonies/Concertos subworks that have no movement relations
-- 2022-01-21: 3943

WITH
    composer_work AS (
        SELECT DISTINCT
            work.id,
            work.type
        FROM
            composer
            INNER JOIN l_artist_work AS law ON composer.id = entity0
            INNER JOIN work ON work.id = entity1
    )
SELECT
    to_work_url(sw.gid),
    -- lat.name,
    SUBSTRING(sw.name for 50) AS name
FROM
    composer_work             AS w
    INNER JOIN work_type      AS wt  ON w.type = wt.id
    INNER JOIN l_work_work    AS lww ON w.id = lww.entity0
    INNER JOIN work           AS sw  ON sw.id = lww.entity1
    INNER JOIN link           AS li  ON li.id = lww.link
    INNER JOIN link_type      AS lt  ON lt.id = li.link_type
    LEFT JOIN link_attribute AS la  ON la.link = lww.link
    -- LEFT JOIN link_attribute_type  AS lat ON la.attribute_type = lat.id
WHERE
    wt.name IN ('Concerto', 'Quartet', 'Sonata', 'Symphony')
    AND lt.name = 'parts'
    AND la.link IS NULL
ORDER BY
    sw.name
;
