SELECT
    contr_src_sys_inst_id,
    contr_src_id,
    COUNT(*) AS row_count
FROM silver_rdm_contract
WHERE contr_src_sys_inst_id = 'MPB001'
GROUP BY
    contr_src_sys_inst_id,
    contr_src_id
HAVING COUNT(*) > 1
ORDER BY row_count DESC;