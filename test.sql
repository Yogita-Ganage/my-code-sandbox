SELECT
    src_session_id,
    COUNT(*) AS row_count
FROM silver_sessions
WHERE z_src_system_id = 'WIP'
GROUP BY src_session_id
HAVING COUNT(*) > 1
ORDER BY row_count DESC;