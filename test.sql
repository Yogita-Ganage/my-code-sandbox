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

%%sql

SELECT
    COUNT(*) AS total_rows,
    SUM(CASE WHEN cprod_name IS NULL OR TRIM(cprod_name) = '' THEN 1 ELSE 0 END) AS blank_cprod_name_count,
    SUM(CASE WHEN cprod_src_id IS NULL OR TRIM(cprod_src_id) = '' THEN 1 ELSE 0 END) AS blank_cprod_src_id_count
FROM silver_rdm_care_product_add_y;


%%sql

SELECT
    cprod_name,
    cprod_src_id,
    cprod_src_sys_inst_id
FROM silver_rdm_care_product_add_y
WHERE LOWER(cprod_name) LIKE '%bereaved emotional support%'
   OR LOWER(cprod_name) LIKE '%emotional support%'
   OR LOWER(cprod_name) LIKE '%repeat call%'
   OR LOWER(cprod_name) LIKE '%assessment%'
ORDER BY cprod_name;