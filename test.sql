SELECT
    ar.id AS assessment_result_id,
    COUNT(DISTINCT s.src_session_id) AS matched_sess_count
FROM silver_drj_assessment_results ar
LEFT JOIN silver_sessions s
    ON s.z_src_system_id = 'MPB'
   AND s.session_care_epi_id = CONCAT('MPB001', ar.user_id)
   AND CAST(ar.created_at AS timestamp)
       BETWEEN CAST(s.session_start_date_time AS timestamp) - INTERVAL 24 HOURS
           AND CAST(s.session_end_date_time AS timestamp) + INTERVAL 48 HOURS
GROUP BY ar.id
HAVING COUNT(DISTINCT s.src_session_id) > 1
LIMIT 50;