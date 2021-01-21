-- instruments families

SELECT
    i0.name AS parent_instrument,
    i1.name AS child_instrument,
    i0.gid  AS parent_mbid,
    i1.gid  AS child_mbid
FROM
    link_type                    AS lt
    INNER JOIN link                    AS l   ON l.link_type = lt.id
    INNER JOIN l_instrument_instrument AS laa ON laa.link = l.id
    INNER JOIN instrument              AS i0  ON i0.id = laa.entity0
    INNER JOIN instrument              AS i1  ON i1.id = laa.entity1
