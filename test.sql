SELECT
    COUNT(*) AS total_joined_rows,
    COUNT(date_s.value_desc) AS raw_session_date_populated,
    COUNT(
        COALESCE(
            TO_DATE(TO_TIMESTAMP(date_s.value_desc, 'dd/MM/yyyy')),
            TO_DATE(TO_TIMESTAMP(date_s.value_desc, 'd/M/yyyy')),
            TO_DATE(TO_TIMESTAMP(date_s.value_desc, 'dd/MM/yy')),
            TO_DATE(TO_TIMESTAMP(date_s.value_desc, 'd/M/yy')),
            TO_DATE(TO_TIMESTAMP(date_s.value_desc, 'dd.M.yy')),
            TO_DATE(TO_TIMESTAMP(date_s.value_desc, 'd.M.yy')),
            TO_DATE(TO_TIMESTAMP(date_s.value_desc, 'dd.M.yyyy')),
            TO_DATE(TO_TIMESTAMP(date_s.value_desc, 'd.M.yyyy')),
            TO_DATE(TO_TIMESTAMP(date_s.value_desc, 'd MMMM yyyy')),
            TO_DATE(TO_TIMESTAMP(date_s.value_desc, 'dd MMMM yyyy'))
        )
    ) AS parsed_form_ans_date_count
FROM temp_silver_wip_activityheader_statistics s
LEFT JOIN temp_silver_wip_activityheader_statistics date_s
    ON date_s.activity_header_id = s.activity_header_id
   AND date_s.group_id = s.group_id
   AND TRIM(LOWER(date_s.type_desc)) IN ('call date', 'session date')
WHERE TRIM(LOWER(s.type_desc)) NOT IN ('call date', 'session date');
