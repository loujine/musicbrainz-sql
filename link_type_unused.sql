-- link types with count 0 == link_type never used?
-- probably used for derived links (child order)

SELECT
    id,
    entity_type0,
    entity_type1,
    name
FROM
    link_type
WHERE
    id NOT IN (
        SELECT DISTINCT link_type FROM link
    )
ORDER BY
    entity_type0,
    entity_type1
