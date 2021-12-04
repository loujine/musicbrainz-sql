-- instrument "strings" with annotation "[string quartet]"
-- 2020-04: 2570
-- 2020-05-20: 1529
-- 2020-09-16: 920
-- 2021-10-16: 124

WITH
string_type AS (
    SELECT
        id
    FROM
        link_attribute_type
    WHERE
        name = 'strings'
)
SELECT DISTINCT
    to_recording_url(r.gid) AS recording_url,
    r.name
FROM
    l_artist_recording AS lar
    INNER JOIN link_attribute_credit AS lac ON lac.link = lar.link
    INNER JOIN recording AS r ON r.id = lar.entity1
    INNER JOIN string_type AS st ON st.id = lac.attribute_type
WHERE
    lac.credited_as = 'string quartet'
ORDER BY
    r.name
