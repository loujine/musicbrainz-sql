-- recordings with "feat. piano" in title
-- 2017: 496
-- 2020-04: 119
-- 2020-05-20: 119
-- 2020-09-16: 105
-- 2021-01-13: 103
-- 2021-10-16: 100

SELECT
    to_recording_url(r.gid) AS recording_url,
    r.name AS recording_name
FROM
    recording AS r
WHERE
    r.name ILIKE '%feat. piano%'
ORDER BY
    recording_name, recording_url
