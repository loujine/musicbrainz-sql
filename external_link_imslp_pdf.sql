-- wrong imslp links with '(File:)pdf'

SELECT
    to_work_url(w.gid) AS work_url,
    w.name AS work_name,
    url
FROM
    work       AS w
    INNER JOIN l_url_work AS luw ON w.id = luw.entity1
    INNER JOIN url        AS u   ON u.id = luw.entity0
WHERE
    url ILIKE '%imslp%pdf%'
ORDER BY
    work_name
