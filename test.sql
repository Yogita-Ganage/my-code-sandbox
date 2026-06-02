SELECT * from emp1
WHERE empno = 7369;


SELECT
    s.activity_header_id,
    s.type_id,
    s.type_desc,
    s.answer_desc,
    s.choice_desc
FROM temp_silver_wip_activityheader_statistics s
WHERE TRIM(LOWER(s.type_desc)) IN ('call date', 'session date')
LIMIT 100;


SELECT
    TRIM(LOWER(s.type_desc)) AS question_name,
    COUNT(*) AS row_count,
    COUNT(s.answer_desc) AS answer_desc_count,
    COUNT(s.choice_desc) AS choice_desc_count
FROM temp_silver_wip_activityheader_statistics s
WHERE TRIM(LOWER(s.type_desc)) IN ('call date', 'session date')
GROUP BY TRIM(LOWER(s.type_desc));



SELECT
    s.activity_header_id,
    s.group_id,
    s.group_desc,
    s.type_id,
    s.type_desc,
    s.choice_desc,
    s.value_desc
FROM temp_silver_wip_activityheader_statistics s
WHERE TRIM(LOWER(s.type_desc)) IN ('call date', 'session date')
LIMIT 100;


SELECT
    TRIM(LOWER(s.type_desc)) AS question_name,
    COUNT(*) AS row_count,
    COUNT(s.value_desc) AS value_desc_count,
    COUNT(DISTINCT s.value_desc) AS distinct_value_count
FROM temp_silver_wip_activityheader_statistics s
WHERE TRIM(LOWER(s.type_desc)) IN ('call date', 'session date')
GROUP BY TRIM(LOWER(s.type_desc));