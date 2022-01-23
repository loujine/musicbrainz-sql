-- discids with all first tracks different by 60 sec

WITH unique_medium AS (
    -- medium with exactly one attached discid
    SELECT medium
    FROM medium_cdtoc
    GROUP BY medium
    HAVING COUNT(*) = 1
), mc AS (
    SELECT
        medium_cdtoc.cdtoc,
        medium_cdtoc.medium
    FROM
        medium_cdtoc
        INNER JOIN unique_medium ON unique_medium.medium = medium_cdtoc.medium
), diffs AS (
SELECT
    a.sort_name AS artist_name,
    cdtoc.discid,
    mc.medium,
    track.position,
    ABS(
        (track_offset[track.position + 1] - track_offset[track.position]) / 75
        - (track.length / 1000)
    ) AS diff
FROM
    mc
    INNER JOIN cdtoc ON mc.cdtoc = cdtoc.id
    INNER JOIN track ON track.medium = mc.medium
    INNER JOIN artist_credit_name AS acn ON track.artist_credit = acn.artist_credit
    INNER JOIN composer AS a ON a.id = acn.artist
WHERE
    track.position < 2
ORDER BY
    artist_name,
    cdtoc.discid,
    mc.medium,
    track.position
), mindiff AS (
SELECT
    artist_name,
    discid,
    medium,
    MIN(diff) AS mindiff
FROM
    diffs
GROUP BY
    artist_name,
    discid,
    medium
)
SELECT
    artist_name,
    mindiff,
    '<https://beta.musicbrainz.org/cdtoc/' || discid || '/set-durations?medium=' || medium || '>' AS url
    -- '<https://beta.musicbrainz.org/cdtoc/' || discid || '/set-durations?medium=' || medium || '&confirm.edit_note=Only%20discid%20attached%20to%20this%20medium>' AS url
FROM
    mindiff
WHERE
    mindiff > 60
;
