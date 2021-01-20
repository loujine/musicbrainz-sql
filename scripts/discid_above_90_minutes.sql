-- discid above X minutes
-- https://beta.musicbrainz.org/edit/74026794
-- 2020-09-16: 219
-- 2020-11-14: > 100min: 0
-- 2020-11-14: >  90min: 24
-- 2020-11-14: >  86min: 272
-- 2021-01-13: >  86min: 282

SELECT
    to_cdtoc_url(cdtoc.discid) AS discid,
    medium_format.name AS format,
    JUSTIFY_INTERVAL(cdtoc.leadout_offset / 75 * INTERVAL '1 second') AS duration
FROM
    cdtoc
    INNER JOIN medium_cdtoc ON medium_cdtoc.cdtoc = cdtoc.id
    INNER JOIN medium ON medium_cdtoc.medium = medium.id
    INNER JOIN medium_format ON medium.format = medium_format.id
WHERE
    leadout_offset > 75 * 60 * 86
ORDER BY
    medium_format.name,
    cdtoc.leadout_offset DESC
;
