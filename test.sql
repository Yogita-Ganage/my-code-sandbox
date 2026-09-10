SELECT
    src_session_id,
    COUNT(*) AS row_count
FROM silver_sessions
WHERE z_src_system_id = 'WIP'
  AND src_session_id IN ('WIP986532', 'WIP962593')
GROUP BY src_session_id;


SELECT *
FROM silver_sessions
WHERE src_session_id IN ('WIP986532', 'WIP962593');