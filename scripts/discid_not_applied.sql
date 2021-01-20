-- discids not applied on a medium (duration difference > 10 sec on track 1 or 2)
-- with unique discid attached to the medium

-- 2021-01-13: 230 (10 sec)
-- 2021-01-13: 801 (5 sec)
WITH unique_medium AS (
    -- medium with exactly one discid
    SELECT
        medium
    FROM
        medium_cdtoc
    GROUP BY
        medium
    HAVING
        COUNT(*) = 1
), mc AS (
    SELECT
        medium_cdtoc.cdtoc,
        medium_cdtoc.medium
    FROM
        medium_cdtoc
        INNER JOIN unique_medium ON unique_medium.medium = medium_cdtoc.medium
)
SELECT DISTINCT
    a.sort_name AS artist_name,
    '<https://beta.musicbrainz.org/cdtoc/' || cdtoc.discid || '/set-durations?medium=' || mc.medium || '&confirm.edit_note=Only%20discid%20attached%20to%20this%20medium>' AS url
FROM
    mc
    INNER JOIN cdtoc ON mc.cdtoc = cdtoc.id
    INNER JOIN track ON track.medium = mc.medium
    INNER JOIN artist_credit_name AS acn ON track.artist_credit = acn.artist_credit
    INNER JOIN composer AS a ON a.id = acn.artist
WHERE
    track.position < 3
    AND ABS(
        (track_offset[track.position + 1] - track_offset[track.position]) / 75
        - (track.length / 1000)
    ) > 10 -- seconds
ORDER BY
    artist_name,
    url
;


-- discids not applied (duration difference > 10 sec on track 1 or 2)
-- 2021-01-13: 9734

-- SELECT
--     COUNT(DISTINCT(mc.id))
--     -- COUNT(mc.id)
-- FROM
--     cdtoc
--     INNER JOIN medium_cdtoc AS mc ON mc.cdtoc = cdtoc.id
--     INNER JOIN track ON track.medium = mc.medium
-- WHERE
--     track.position < 3
--     AND ABS(
--         (track_offset[track.position + 1] - track_offset[track.position]) / 75
--         - (track.length / 1000)
--     ) > 10 -- seconds
-- ;
