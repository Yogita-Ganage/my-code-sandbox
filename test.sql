SELECT
    cprod_name,
    cprod_src_id,
    cprod_src_sys_inst_id
FROM silver_rdm_care_product_add
WHERE cprod_src_sys_inst_id = 'WIP001'
  AND (
        LOWER(cprod_name) LIKE '%bereaved emotional support%'
     OR LOWER(cprod_name) LIKE '%emotional support%'
     OR LOWER(cprod_name) LIKE '%repeat call%'
     OR LOWER(cprod_name) LIKE '%assessment%'
  )
ORDER BY cprod_name;



SELECT
    cprod_id,
    cprod_name,
    cprod_src_id,
    cprod_src_sys_inst_id
FROM silver_rdm_care_product
WHERE cprod_src_sys_inst_id = 'WIP001'
  AND (
        LOWER(cprod_name) LIKE '%bereaved emotional support%'
     OR LOWER(cprod_name) LIKE '%emotional support%'
     OR LOWER(cprod_name) LIKE '%repeat call%'
     OR LOWER(cprod_name) LIKE '%assessment%'
  )
ORDER BY cprod_name;