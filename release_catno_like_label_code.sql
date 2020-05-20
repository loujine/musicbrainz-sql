-- release catno like LC-xxxxx that are probably label codes
-- 2020-04: 66
-- 2020-05-20: 53

SELECT
    to_release_url(r.gid),
    rl.catalog_number,
    l.label_code,
    l.name AS label_name
FROM
    release_label AS rl
    INNER JOIN release  AS r  ON r.id = rl.release
    INNER JOIN label    AS l  ON l.id = rl.label
WHERE
    rl.catalog_number ILIKE 'LC-%'
    AND l.name NOT ILIKE 'l% c%'
ORDER BY
    l.name,
    rl.catalog_number
