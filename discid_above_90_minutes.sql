-- discid above 90 minutes
-- 2020-09-16: 219

SELECT
    medium_format.name,
    to_cdtoc_url(cdtoc.discid),
    cdtoc.leadout_offset / 60 / 75 AS duration_minutes
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
