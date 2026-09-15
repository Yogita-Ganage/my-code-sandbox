%%sql

SELECT
    LOWER(TRIM(cprod_src_sys_inst_src_id)) AS src_instance,
    LOWER(TRIM(cprod_src_id)) AS normalized_cprod_src_id,
    COUNT(*) AS row_cnt,
    COLLECT_SET(cprod_id) AS cprod_ids,
    COLLECT_SET(cprod_src_id) AS original_values
FROM silver_rdm_care_product
WHERE cprod_src_sys_inst_src_id LIKE 'SONE%'
GROUP BY
    LOWER(TRIM(cprod_src_sys_inst_src_id)),
    LOWER(TRIM(cprod_src_id))
HAVING COUNT(*) > 1
ORDER BY row_cnt DESC;