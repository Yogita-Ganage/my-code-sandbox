WITH wip_base AS (
    SELECT
        s.activity_header_id,
        s.group_id,
        s.group_desc,
        s.type_id,
        s.type_desc,
        s.src_answer_desc
    FROM temp_silver_wip_activityheader_statistics s
    WHERE s.group_desc IN (
        'CYP Triage Assessment Presenting Issues',
        'Presenting Issues'
    )
),
answer_counts AS (
    SELECT
        activity_header_id,
        group_id,
        type_id,
        COUNT(*) AS answer_count
    FROM wip_base
    GROUP BY
        activity_header_id,
        group_id,
        type_id
    HAVING COUNT(*) > 1
)
SELECT
    b.activity_header_id,
    b.group_desc,
    b.type_desc,
    c.answer_count,
    b.src_answer_desc
FROM wip_base b
JOIN answer_counts c
    ON b.activity_header_id = c.activity_header_id
    AND b.group_id = c.group_id
    AND b.type_id = c.type_id
ORDER BY
    c.answer_count DESC,
    b.activity_header_id,
    b.group_desc,
    b.type_desc
LIMIT 50;