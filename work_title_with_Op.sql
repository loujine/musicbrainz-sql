-- Works with capitalized "Op. " contrary to classical guidelines
-- 2017-01-04: 398
-- 2020-04-24: 615
-- 2020-05-20: 526

SELECT
    to_work_url(gid),
    name
FROM
    work
WHERE
    name LIKE '%Op. %'
