-- same barcode on more than 5 releases
-- not all in same RG or country

SELECT
    barcode,
    to_release_url(gid),
    name
FROM
    release
WHERE
    barcode IN (
        SELECT
            barcode
        FROM
            release AS r
            INNER JOIN release_country AS c ON r.id = c.release
        WHERE
            NOT r.barcode = ''
        GROUP BY
            r.barcode,
            r.release_group,
            c.country
            HAVING
                COUNT(r.barcode) > 5
                AND COUNT(r.release_group) > 1
                AND COUNT(c.country) > 1
        )
ORDER BY
    name
