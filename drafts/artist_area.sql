-- artist area not a country
-- 2020-05: 139377
-- 2020-09-16: 150353

SELECT
    COUNT(*)
FROM
    artist
    INNER JOIN area ON artist.area = area.id
WHERE
    area.type != 1
