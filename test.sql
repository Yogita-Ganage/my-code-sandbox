SELECT
    s.activity_header_id,
    s.group_id,
    s.group_desc,
    COUNT(date_s.value_desc) AS matched_date_rows
FROM temp_silver_wip_activityheader_statistics s
LEFT JOIN temp_silver_wip_activityheader_statistics date_s
    ON date_s.activity_header_id = s.activity_header_id
   AND date_s.group_id = s.group_id
   AND TRIM(LOWER(date_s.group_desc)) = TRIM(LOWER(s.group_desc))
   AND TRIM(LOWER(date_s.type_desc)) IN ('call date', 'session date')
WHERE TRIM(LOWER(s.type_desc)) NOT IN ('call date', 'session date')
GROUP BY
    s.activity_header_id,
    s.group_id,
    s.group_desc
HAVING COUNT(date_s.value_desc) > 1
ORDER BY matched_date_rows DESC;