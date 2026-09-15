SELECT
    src_session_id,
    COUNT(*) AS row_count,
    COUNT(DISTINCT session_patient_id) AS patient_count
FROM silver_sessiony_test
WHERE z_src_system_id = 'WIP'
GROUP BY src_session_id
HAVING COUNT(*) > 1
ORDER BY patient_count DESC, src_session_id;