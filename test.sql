SELECT *
FROM silver_rdm_source_systems
WHERE src_sys_inst_id = 'MPB001';

SELECT
    src_sys_inst_id,
    COUNT(*)
FROM silver_rdm_source_systems
GROUP BY src_sys_inst_id
HAVING COUNT(*) > 1;