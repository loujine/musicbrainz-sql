-- same name, barcode, catno, country on releases

WITH barcount AS (
    SELECT
        COUNT(DISTINCT r.id) AS cnt,
        UNNEST(ARRAY_AGG(r.id)) AS id
    FROM
        release AS r
        LEFT OUTER JOIN release_country AS c ON r.id = c.release
        LEFT OUTER JOIN release_status AS rs ON r.status = rs.id
        INNER JOIN release_label AS l ON r.id = l.release
    WHERE
        NOT r.barcode = ''
        AND NOT rs.name = 'Pseudo-Release' -- translated tracklists
    GROUP BY
        r.name,
        r.comment,
        r.barcode,
        l.catalog_number,
        c.country
    HAVING
        COUNT(DISTINCT r.id) > 2
    ORDER BY
        cnt DESC
    )
SELECT
    barcount.cnt,
    r.barcode,
    to_release_url(r.gid),
    SUBSTRING(r.name for 50) AS name,
    SUBSTRING(r.comment for 20) AS disambig
FROM
    release AS r
    INNER JOIN barcount ON barcount.id = r.id
ORDER BY
    barcount.cnt DESC,
    r.barcode,
    r.id
