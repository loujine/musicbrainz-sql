-- discid above 90 minutes
-- 2020-09-16: 219

SELECT
    to_md(to_cdtoc_url(cdtoc.discid)) AS discid,
    medium_format.name AS format,
    JUSTIFY_INTERVAL(cdtoc.leadout_offset / 75 * INTERVAL '1 second') AS duration
FROM
    cdtoc
    INNER JOIN medium_cdtoc ON medium_cdtoc.cdtoc = cdtoc.id
    INNER JOIN medium ON medium_cdtoc.medium = medium.id
    INNER JOIN medium_format ON medium.format = medium_format.id
WHERE
    leadout_offset > 75 * 60 * 90
ORDER BY
    medium_format.name,
    cdtoc.leadout_offset DESC
;
