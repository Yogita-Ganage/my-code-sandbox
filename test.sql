-- Get the exact organisation linked to the session customer
LEFT JOIN silver_wip_businessrole AS cust_br
    ON cust_br.id = AHRD.customer_id

LEFT JOIN silver_wip_organisation AS org
    ON org.id = cust_br.business_actor_id



SELECT
    src_session_id,
    COUNT(*) AS row_count,
    COUNT(DISTINCT session_patient_id) AS patient_count
FROM silver_sessiony_test
WHERE z_src_system_id = 'WIP'
GROUP BY src_session_id
HAVING COUNT(*) > 1
ORDER BY patient_count DESC, src_session_id;