SELECT
    LOWER(TRIM(session_status_src_id)) AS session_status_src_id_normalised,
    COUNT(*) AS record_count
FROM silver_rdm_session_status
WHERE session_status_src_id IS NOT NULL
GROUP BY LOWER(TRIM(session_status_src_id))
HAVING COUNT(*) > 1
ORDER BY record_count DESC;


SELECT *
FROM silver_rdm_session_status
WHERE LOWER(TRIM(session_status_src_id)) IN (
    SELECT LOWER(TRIM(session_status_src_id))
    FROM silver_rdm_session_status
    WHERE session_status_src_id IS NOT NULL
    GROUP BY LOWER(TRIM(session_status_src_id))
    HAVING COUNT(*) > 1
)
ORDER BY LOWER(TRIM(session_status_src_id));