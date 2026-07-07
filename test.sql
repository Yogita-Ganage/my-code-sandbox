SELECT
    ah.file_number,
    ae.id AS activity_entry_id,
    ae.activity_date_time,

    asv.is_primary,
    ah.service_type_id,
    asv.service_id,
    ae.activity_type_id,

    ast.description AS service_type,
    srv.description AS service_activity,
    atp.description AS activity_type,

    CONCAT(ast.description, '_', srv.description, '_', atp.description) AS expected_cprod_name,

    CASE WHEN asv.is_primary = true THEN 1 ELSE 0 END AS passes_primary_filter,
    CASE WHEN ah.service_type_id IS NOT NULL THEN 1 ELSE 0 END AS has_service_type,
    CASE WHEN asv.service_id IS NOT NULL THEN 1 ELSE 0 END AS has_service,
    CASE WHEN ae.activity_type_id IS NOT NULL THEN 1 ELSE 0 END AS has_activity_type

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