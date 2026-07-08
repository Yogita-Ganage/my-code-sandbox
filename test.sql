SELECT
    z_src_system_id,
    COUNT(*) AS total_records,
    SUM(CASE WHEN session_start_date_time IS NULL THEN 1 ELSE 0 END) AS blank_start_datetime_count,
    SUM(CASE WHEN session_start_date_time IS NOT NULL THEN 1 ELSE 0 END) AS populated_start_datetime_count
FROM silver_sessions
WHERE z_src_system_id = 'SONE'
GROUP BY z_src_system_id;


SELECT
    COUNT(*) AS total_appointments,
    SUM(CASE WHEN date_start IS NULL THEN 1 ELSE 0 END) AS blank_date_start_count,
    SUM(CASE WHEN date_start IS NOT NULL THEN 1 ELSE 0 END) AS populated_date_start_count
FROM silver_sone_srappointment;