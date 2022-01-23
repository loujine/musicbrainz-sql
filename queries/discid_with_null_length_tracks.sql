-- discids attached to a medium with unknown track duration

WITH mc AS (
    SELECT
        UNNEST(ARRAY_AGG(cdtoc)) AS cdtoc,
        medium
    FROM
        medium_cdtoc
    GROUP BY
        medium
    HAVING
        COUNT(medium) = 1
), null_duration AS (
SELECT DISTINCT
    cdtoc.discid,
    mc.medium,
    release.gid,
    track.artist_credit
FROM
    mc
    INNER JOIN cdtoc ON mc.cdtoc = cdtoc.id
    INNER JOIN track ON track.medium = mc.medium
    INNER JOIN medium ON medium.id = mc.medium
    INNER JOIN release ON release.id = medium.release
WHERE
    track.length IS NULL
    AND NOT track.is_data_track
ORDER BY
    cdtoc.discid,
    mc.medium
)
SELECT DISTINCT
    artist.sort_name AS artist_name,
    '<https://beta.musicbrainz.org/cdtoc/' || discid || '#' || null_duration.gid || '>'
FROM
    null_duration
    INNER JOIN artist_credit_name AS acn ON null_duration.artist_credit = acn.artist_credit
    -- INNER JOIN artist ON artist.id = acn.artist
    INNER JOIN composer AS artist ON artist.id = acn.artist
ORDER BY
    artist.sort_name
;
