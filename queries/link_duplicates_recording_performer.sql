-- duplicate relationships between performer and recording

SELECT
    SUBSTRING(a.sort_name for 25) AS performer_name,
    to_recording_url(r.gid) AS recording_url,
    SUBSTRING(r.name for 50) AS recording_name
FROM
    l_artist_recording AS lar
    INNER JOIN pianist AS a ON a.id = lar.entity0
    INNER JOIN recording AS r ON r.id = lar.entity1
    INNER JOIN link AS li ON li.id = lar.link
    INNER JOIN link_type AS lt ON lt.id = li.link_type
GROUP BY
    r.id,
    r.gid,
    r.name,
    a.sort_name,
    lt.name
HAVING
    COUNT(r.gid) > 1
ORDER BY
    performer_name,
    recording_name
;

SELECT
    SUBSTRING(a.sort_name for 25) AS performer_name,
    to_recording_url(r.gid) AS recording_url,
    SUBSTRING(r.name for 50) AS recording_name
FROM
    l_artist_recording AS lar
    INNER JOIN violinist AS a ON a.id = lar.entity0
    INNER JOIN recording AS r ON r.id = lar.entity1
    INNER JOIN link AS li ON li.id = lar.link
    INNER JOIN link_type AS lt ON lt.id = li.link_type
GROUP BY
    r.id,
    r.gid,
    r.name,
    a.sort_name,
    lt.name
HAVING
    COUNT(r.gid) > 1
ORDER BY
    performer_name,
    recording_name
;

SELECT
    SUBSTRING(a.sort_name for 25) AS performer_name,
    to_recording_url(r.gid) AS recording_url,
    SUBSTRING(r.name for 50) AS recording_name
FROM
    l_artist_recording AS lar
    INNER JOIN quartet AS a ON a.id = lar.entity0
    INNER JOIN recording AS r ON r.id = lar.entity1
    INNER JOIN link AS li ON li.id = lar.link
    INNER JOIN link_type AS lt ON lt.id = li.link_type
GROUP BY
    r.id,
    r.gid,
    r.name,
    a.sort_name,
    lt.name
HAVING
    COUNT(r.gid) > 1
ORDER BY
    performer_name,
    recording_name
;

SELECT
    SUBSTRING(a.sort_name for 25) AS performer_name,
    to_recording_url(r.gid) AS recording_url,
    SUBSTRING(r.name for 50) AS recording_name
FROM
    l_artist_recording AS lar
    INNER JOIN conductor AS a ON a.id = lar.entity0
    INNER JOIN recording AS r ON r.id = lar.entity1
    INNER JOIN link AS li ON li.id = lar.link
    INNER JOIN link_type AS lt ON lt.id = li.link_type
GROUP BY
    r.id,
    r.gid,
    r.name,
    a.sort_name,
    lt.name
HAVING
    COUNT(r.gid) > 1
ORDER BY
    performer_name,
    recording_name
;
