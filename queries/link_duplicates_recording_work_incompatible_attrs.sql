-- Recordings related to the same work with incompatible attributes (partial/not, live/not, instrumental/not)

WITH
    composer_work AS (
        SELECT DISTINCT
            work.id,
            work.gid
        FROM
            composer
            INNER JOIN l_artist_work AS law ON composer.id = entity0
            INNER JOIN work ON work.id = entity1
    ),
    multiple_recording AS (
        SELECT
            composer_work.gid AS wmbid,
            r.gid AS rmbid,
            r.name AS name,
            UNNEST(ARRAY_AGG(lrw.link)) AS link_id
        FROM
            composer_work
            INNER JOIN l_recording_work AS lrw ON composer_work.id = lrw.entity1
            INNER JOIN recording        AS r   ON r.id = lrw.entity0
        GROUP BY
            wmbid, r.gid, r.name
        HAVING
            count(*) > 1
    ),
    link_with_attrs AS (
        SELECT
            wmbid,
            rmbid,
            name,
            link_id,
            ARRAY_AGG(la.attribute_type) AS attrs
        FROM
            multiple_recording
            LEFT JOIN link_attribute AS la ON multiple_recording.link_id = la.link
        GROUP BY
            wmbid, rmbid, name, link_id
    )
SELECT DISTINCT
    to_recording_url(rmbid), name -- , attrs
FROM
    link_with_attrs
WHERE
    578 = ANY(attrs)    -- live
    OR 579 = ANY(attrs) -- partial
    OR 580 = ANY(attrs) -- instrumental
ORDER BY
    name, to_recording_url(rmbid)
;
