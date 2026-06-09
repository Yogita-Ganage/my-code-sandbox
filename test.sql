SELECT
    sc.id_appointment,
    CONCAT('SONE', sc.id_appointment) AS derived_session_id,
    COUNT(*) AS record_count
FROM silver_sone_srcode sc
GROUP BY
    sc.id_appointment,
    CONCAT('SONE', sc.id_appointment)
ORDER BY
    record_count DESC
LIMIT 20;