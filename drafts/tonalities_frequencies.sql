-- frequencies of tonalities assigned to works

WITH
counts AS (SELECT
    COUNT(work.name) AS cnt,
    work_attribute_type_allowed_value.value AS key,
    work_attribute_type_allowed_value.child_order
FROM
    work
    INNER JOIN work_attribute ON work_attribute.work = work.id
    INNER JOIN work_attribute_type ON work_attribute.work_attribute_type = work_attribute_type.id
    INNER JOIN work_attribute_type_allowed_value ON work_attribute.work_attribute_type_allowed_value = work_attribute_type_allowed_value.id
WHERE
    work_attribute_type.name = 'Key'
GROUP BY
    work_attribute_type_allowed_value.value,
    work_attribute_type_allowed_value.child_order
), nocounts AS (
SELECT
    value AS key,
    work_attribute_type_allowed_value.child_order
FROM
    work_attribute_type_allowed_value
    INNER JOIN work_attribute_type ON work_attribute_type.id = work_attribute_type_allowed_value.work_attribute_type
WHERE
    work_attribute_type.name = 'Key'
    AND value NOT IN (SELECT key FROM counts)
), results AS (
SELECT
    cnt, key, child_order
FROM
    counts
UNION
SELECT
    0, key, child_order
FROM
    nocounts
ORDER BY child_order
)
SELECT
    key, cnt
FROM
    results
;
