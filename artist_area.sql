-- artist area not a country
-- 2020-05: 139377

SELECT
    COUNT(*)
FROM
    artist
    INNER JOIN area ON artist.area = area.id
WHERE
    area.type != 1
