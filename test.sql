%%sql

WITH sample_headers AS (
    SELECT DISTINCT activity_header_id
    FROM temp_silver_wip_activityheader_statistics
    WHERE TRIM(LOWER(type_desc)) IN ('call date', 'session date')
    LIMIT 5
)

SELECT
    s.activity_header_id,
    s.type_id,
    s.type_desc,
    s.group_id,
    s.group_desc,
    s.value_desc,
    s.src_answer_desc
FROM temp_silver_wip_activityheader_statistics s
INNER JOIN sample_headers h
    ON s.activity_header_id = h.activity_header_id
ORDER BY
    s.activity_header_id,
    s.group_id,
    s.type_id;