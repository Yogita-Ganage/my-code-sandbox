%%sql

SELECT
    cprod_src_id,
    COUNT(*) AS cnt,
    COUNT(DISTINCT cprod_src_sys_inst_src_id) AS instance_cnt,
    COUNT(DISTINCT cprod_src_name) AS name_cnt
FROM silver_rdm_care_product
WHERE cprod_src_sys_inst_src_id LIKE 'SONE%'
GROUP BY cprod_src_id
HAVING COUNT(*) > 1
ORDER BY cnt DESC;