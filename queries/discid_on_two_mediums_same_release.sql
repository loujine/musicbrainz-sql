-- Same discid set on different mediums of the same release

SELECT DISTINCT
    to_release_url(release.gid), release.name
FROM
    medium_cdtoc
    INNER JOIN medium ON medium.id = medium_cdtoc.medium
    INNER JOIN release ON medium.release = release.id
GROUP BY
    to_release_url(release.gid), release.name, medium_cdtoc.cdtoc
HAVING
    COUNT(*) > 1
ORDER BY
    release.name
;
