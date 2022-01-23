-- opera subworks that have type opera
-- 2022-01-21: 646

SELECT
    to_work_url(sw.gid),
    sw.name
FROM
    work                   AS w
    INNER JOIN work_type   AS wt  ON w.type = wt.id
    INNER JOIN l_work_work AS lww ON w.id = lww.entity0
    INNER JOIN work        AS sw  ON sw.id = lww.entity1
    INNER JOIN link        AS li  ON li.id = lww.link
    INNER JOIN link_type   AS lt  ON lt.id = li.link_type
    LEFT JOIN  work_type   AS swt ON sw.type = swt.id
WHERE
    swt.name = 'Opera'
    AND wt.name = 'Opera'  -- optional
    AND lt.name = 'parts'
    AND (                  -- optional
        sw.name ILIKE '%act %'
        OR sw.name ILIKE '%acte %'
        OR sw.name ILIKE '%akt %'
        OR sw.name ILIKE '%atto %'
    )
ORDER BY
    sw.name
;


-- opera subworks that have act relations

SELECT
    to_work_url(sw.gid),
    -- lat.name,
    sw.name
FROM
    work                      AS w
    INNER JOIN work_type      AS wt  ON w.type = wt.id
    INNER JOIN l_work_work    AS lww ON w.id = lww.entity0
    INNER JOIN work           AS sw  ON sw.id = lww.entity1
    INNER JOIN link           AS li  ON li.id = lww.link
    INNER JOIN link_type      AS lt  ON lt.id = li.link_type
    INNER JOIN link_attribute AS la  ON la.link = lww.link
    INNER JOIN link_attribute_type  AS lat ON la.attribute_type = lat.id
    LEFT JOIN  work_type      AS swt ON sw.type = swt.id
WHERE
    wt.name = 'Opera'
    AND (
        sw.name ILIKE '%act %'
        OR sw.name ILIKE '%acte %'
        OR sw.name ILIKE '%akt %'
        OR sw.name ILIKE '%atto %'
    )
    AND lt.name = 'parts'
    AND lat.name  = 'act'
ORDER BY
    sw.name
;


-- opera subworks that are named "act" but not act/number relations
-- 2022-01-21: 740

SELECT
    to_work_url(sw.gid),
    -- lat.name,
    sw.name
FROM
    work                      AS w
    INNER JOIN work_type      AS wt  ON w.type = wt.id
    INNER JOIN l_work_work    AS lww ON w.id = lww.entity0
    INNER JOIN work           AS sw  ON sw.id = lww.entity1
    INNER JOIN link           AS li  ON li.id = lww.link
    INNER JOIN link_type      AS lt  ON lt.id = li.link_type
    LEFT JOIN link_attribute  AS la  ON la.link = lww.link
    -- LEFT JOIN link_attribute_type  AS lat ON la.attribute_type = lat.id
    LEFT JOIN  work_type      AS swt ON sw.type = swt.id
WHERE
    wt.name = 'Opera'
    AND (
        sw.name ILIKE '%act %'
        OR sw.name ILIKE '%acte %'
        OR sw.name ILIKE '%akt %'
        OR sw.name ILIKE '%atto %'
    )
    AND lt.name = 'parts'
    AND swt.name != 'Overture'
    AND (
        li.attribute_count = 0
        OR la.attribute_type IS NULL
    )
ORDER BY
    sw.name
;
