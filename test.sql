SELECT
    ah.file_number,
    ae.activity_date_time,

    ast.description AS service_type,
    srv.description AS service_activity,
    atp.description AS activity_type,

    CONCAT(ast.description, '_', srv.description, '_', atp.description) AS expected_cprod_name,

    CONCAT('WIP001_', CONCAT(ast.description, '_', srv.description, '_', atp.description)) AS expected_cprod_src_id,

    cp.cprod_id AS matched_cprod_id,
    cp.cprod_name AS matched_cprod_name,
    cp.cprod_src_id AS matched_cprod_src_id,
    cp.cprod_src_sys_inst_id AS matched_cprod_src_sys_inst_id

FROM silver_wip_activityentry ae

LEFT JOIN silver_wip_activityheader ah
    ON ae.activity_header_id = ah.id

LEFT JOIN silver_wip_activityservice asv
    ON ae.activity_service_id = asv.id

LEFT JOIN silver_wip_servicetype ast
    ON ah.service_type_id = ast.id

LEFT JOIN silver_wip_service srv
    ON asv.service_id = srv.id

LEFT JOIN silver_wip_activitytype atp
    ON ae.activity_type_id = atp.id

LEFT JOIN silver_rdm_care_product cp
    ON LOWER(TRIM(cp.cprod_src_id)) =
       LOWER(TRIM(CONCAT('WIP001_', CONCAT(ast.description, '_', srv.description, '_', atp.description))))
   AND cp.cprod_src_sys_inst_id = 'WIP001'

WHERE TRIM(CAST(ah.file_number AS STRING)) IN ('451027', '306826')
  AND asv.is_primary = true
  AND ah.id IS NOT NULL
  AND ah.service_type_id IS NOT NULL
  AND asv.service_id IS NOT NULL
  AND ae.activity_type_id IS NOT NULL

ORDER BY ah.file_number, ae.activity_date_time;






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






SELECT
    a.cprod_name,
    a.cprod_src_id,
    a.cprod_src_sys_inst_id,
    r.cprod_id AS existing_cprod_id
FROM silver_rdm_care_product_add_y a
LEFT JOIN silver_rdm_care_product r
    ON LOWER(TRIM(a.cprod_src_id)) = LOWER(TRIM(r.cprod_src_id))
WHERE LOWER(a.cprod_name) LIKE '%bereaved emotional support%'
   OR LOWER(a.cprod_name) LIKE '%emotional support%'
   OR LOWER(a.cprod_name) LIKE '%repeat call%'
   OR LOWER(a.cprod_name) LIKE '%assessment%'
ORDER BY a.cprod_name;






