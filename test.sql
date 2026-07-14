SELECT
    source_name,
    source_id,
    source_system_instance_id,
    COUNT(*) AS record_count
FROM silver_rdm_contracts_add
GROUP BY
    source_name,
    source_id,
    source_system_instance_id
HAVING COUNT(*) > 1
ORDER BY record_count DESC;



SELECT
    source_name,
    source_id,
    source_system_instance_id,
    COUNT(*) AS record_count
FROM silver_rdm_contracts
GROUP BY
    source_name,
    source_id,
    source_system_instance_id
HAVING COUNT(*) > 1
ORDER BY record_count DESC;