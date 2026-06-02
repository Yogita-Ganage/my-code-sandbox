SELECT
    activity_header_id,
    group_id,
    group_desc,
    COUNT(*) AS date_row_count,
    COUNT(DISTINCT id) AS distinct_date_ids,
    COUNT(DISTINCT value_desc) AS distinct_date_values
FROM test_temp_silver_wip_activityheader_statistics
WHERE TRIM(LOWER(type_desc)) IN ('call date', 'session date')
GROUP BY
    activity_header_id,
    group_id,
    group_desc
HAVING COUNT(DISTINCT value_desc) > 1
ORDER BY distinct_date_values DESC;




WITH date_lookup AS (
    SELECT
        activity_header_id,
        group_id,
        group_desc,
        MAX(value_desc) AS raw_session_date
    FROM test_temp_silver_wip_activityheader_statistics
    WHERE TRIM(LOWER(type_desc)) IN ('call date', 'session date')
    GROUP BY
        activity_header_id,
        group_id,
        group_desc
)

SELECT
    s.activity_header_id,
    s.group_id,
    s.group_desc,
    s.type_desc AS answer_question,
    s.src_answer_desc AS answer_value,
    dl.raw_session_date,

    COALESCE(
        TO_DATE(TO_TIMESTAMP(dl.raw_session_date, 'dd/MM/yyyy')),
        TO_DATE(TO_TIMESTAMP(dl.raw_session_date, 'd/M/yyyy')),
        TO_DATE(TO_TIMESTAMP(dl.raw_session_date, 'dd/MM/yy')),
        TO_DATE(TO_TIMESTAMP(dl.raw_session_date, 'd/M/yy')),
        TO_DATE(TO_TIMESTAMP(dl.raw_session_date, 'dd.M.yy')),
        TO_DATE(TO_TIMESTAMP(dl.raw_session_date, 'd.M.yy')),
        TO_DATE(TO_TIMESTAMP(dl.raw_session_date, 'dd.M.yyyy')),
        TO_DATE(TO_TIMESTAMP(dl.raw_session_date, 'd.M.yyyy')),
        TO_DATE(TO_TIMESTAMP(dl.raw_session_date, 'd MMMM yyyy')),
        TO_DATE(TO_TIMESTAMP(dl.raw_session_date, 'dd MMMM yyyy'))
    ) AS expected_form_ans_date

FROM test_temp_silver_wip_activityheader_statistics s
LEFT JOIN date_lookup dl
    ON dl.activity_header_id = s.activity_header_id
   AND dl.group_id = s.group_id
   AND TRIM(LOWER(dl.group_desc)) = TRIM(LOWER(s.group_desc))
WHERE TRIM(LOWER(s.type_desc)) NOT IN ('call date', 'session date')
LIMIT 100;