-- release with relationship to composer (should be on related works)
-- 2020-04: 121
-- 2020-09-16: 125

SELECT
    a.sort_name AS artist_name,
    lt.name AS link_type,
    to_release_url(r.gid) AS release_url,
    SUBSTRING(r.name for 100) AS release_name
FROM
    l_artist_release AS lar
    INNER JOIN composer AS a ON a.id = lar.entity0
    INNER JOIN release AS r ON r.id = lar.entity1
    INNER JOIN link AS li ON li.id = lar.link
    INNER JOIN link_type AS lt ON lt.id = li.link_type
WHERE
    li.link_type IN (55, 57, 40, 41, 54, 295)
ORDER BY
    link_type,
    artist_name,
    release_name
