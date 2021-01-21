-- Works with capitalized "Op. " contrary to classical guidelines

-- 2017-01-04: 398
-- 2020-04-24: 615
-- 2020-05-20: 526
-- 2020-09-16: 599
-- 2021-01-13: 509

SELECT
    to_work_url(gid) AS work_url,
    name
FROM
    work
WHERE
    name LIKE '%Op. %'
;

-- 2020-09-16: 119
-- 2021-01-13: 90

-- SELECT
--     to_work_url(gid) AS work_url,
--     name
-- FROM
--     work
-- WHERE
--     name LIKE '% Flat %' OR name LIKE '% Sharp %'
-- ;
