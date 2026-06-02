SELECT
    activity_header_id,
    group_id,
    group_desc,
    type_id,
    type_desc,
    value_desc,
    COUNT(*) AS row_count
FROM temp_silver_wip_activityheader_statistics
WHERE TRIM(LOWER(type_desc)) IN ('call date', 'session date')
GROUP BY
    activity_header_id,
    group_id,
    group_desc,
    type_id,
    type_desc,
    value_desc
HAVING COUNT(*) > 1
ORDER BY row_count DESC;