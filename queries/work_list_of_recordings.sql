-- recordings durations for a given work

SELECT
    to_recording_url(r.gid) AS recording_url,
    r.length,
    ac.name
FROM
    artist_credit AS ac
    INNER JOIN recording AS r ON r.artist_credit = ac.id
    INNER JOIN l_recording_work AS lrw ON r.id = lrw.entity0
    INNER JOIN work AS w ON w.id = lrw.entity1
    LEFT OUTER JOIN link_attribute AS la ON la.link = lrw.link
WHERE
    -- Keyboard Concerto in D minor, BWV 1052: I. Allegro
    w.gid = '29930a4b-b3a6-3b82-be2f-f19a06a76175'
    -- not partial recording
    AND (la.attribute_type IS NULL OR la.attribute_type != 579)
ORDER BY
    r.length
