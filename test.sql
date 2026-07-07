SELECT
    ah.file_number,
    ae.activity_date_time,

    ast.description AS service_type,
    srv.description AS service_activity,
    atp.description AS activity_type,

    CONCAT(ast.description, ' - ', srv.description, ' - ', atp.description) AS expected_cprod_name,

    CONCAT('WIP001_', CONCAT(ast.description, '_', srv.description, '_', atp.description)) AS expected_cprod_src_id,

    cp.cprod_id AS matched_cprod_id,
    cp.cprod_src_name AS matched_cprod_src_name,
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