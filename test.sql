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
)
SELECT
    CASE
        WHEN answer_count > 1 THEN 'Multi answer'
        ELSE 'Single answer'
    END AS answer_pattern,
    COUNT(*) AS record_count
FROM answer_counts
GROUP BY
    CASE
        WHEN answer_count > 1 THEN 'Multi answer'
        ELSE 'Single answer'
    END;