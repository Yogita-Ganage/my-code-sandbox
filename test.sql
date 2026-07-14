SELECT
    LOWER(TRIM(session_status_src_id)) AS session_status_src_id_normalised,
    COUNT(*) AS record_count
FROM silver_rdm_session_status_add
WHERE session_status_src_id IS NOT NULL
GROUP BY LOWER(TRIM(session_status_src_id))
HAVING COUNT(*) > 1
ORDER BY record_count DESC;