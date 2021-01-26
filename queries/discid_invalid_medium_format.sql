-- discIDs attached to medium with incompatible format

SELECT
    to_cdtoc_url(c.discid) AS url,
    mf.name AS format
FROM
    medium_cdtoc AS mc
    INNER JOIN medium AS m ON m.id = mc.medium
    INNER JOIN cdtoc AS c ON c.id = mc.cdtoc
    INNER JOIN medium_format AS mf ON mf.id = m.format
WHERE
    NOT mf.has_discids
ORDER BY
    format, url;
