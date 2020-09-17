-- duplicate relationships between performer and recording (filtered on main composers)
-- TODO unselect performer with different instruments

-- 2020-09-16: 1167

SELECT
    SUBSTRING(a.sort_name for 25) AS performer_name,
    to_recording_url(r.gid) AS recording_url,
    SUBSTRING(r.name for 50) AS recording_name
FROM
    l_artist_recording AS lar
    INNER JOIN artist AS a ON a.id = lar.entity0
    INNER JOIN recording AS r ON r.id = lar.entity1
    INNER JOIN link AS li ON li.id = lar.link
    INNER JOIN link_type AS lt ON lt.id = li.link_type
WHERE
    a.begin_date_year < 1900
GROUP BY
    r.id,
    a.sort_name,
    lt.name
HAVING
    COUNT(r.gid) > 1
ORDER BY
    performer_name
