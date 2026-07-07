SELECT
    ah.file_number,
    ae.activity_date_time,
    ast.description AS service_type,
    srv.description AS service_activity,
    atp.description AS activity_type,
    CONCAT(ast.description, ' - ', srv.description, ' - ', atp.description) AS expected_cprod_name
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
WHERE TRIM(CAST(ah.file_number AS STRING)) IN ('451027', '306826')
ORDER BY ah.file_number, ae.activity_date_time;