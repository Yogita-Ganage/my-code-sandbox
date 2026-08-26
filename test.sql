SELECT DISTINCT
    ah.service_type_id,
    st.description AS service_type,
    ae.activity_service_id,
    acs.service_id,
    s.description AS service_activity,
    ae.activity_type_id,
    at.description AS activity_type
FROM silver_wip_activityentry ae

LEFT JOIN silver_wip_activityheader ah
    ON ae.activity_header_id = ah.id

LEFT JOIN silver_wip_servicetype st
    ON ah.service_type_id = st.id

LEFT JOIN silver_wip_activityservice acs
    ON ae.activity_service_id = acs.id

LEFT JOIN silver_wip_service s
    ON acs.service_id = s.id

LEFT JOIN silver_wip_activitytype at
    ON ae.activity_type_id = at.id

WHERE st.id IS NULL
   OR s.id IS NULL
   OR at.id IS NULL;




SELECT
    COUNT(*) AS total_rows,
    SUM(CASE WHEN ah.service_type_id IS NULL THEN 1 ELSE 0 END) AS null_service_type_rows
FROM silver_wip_activityentry ae
LEFT JOIN silver_wip_activityheader ah
    ON ae.activity_header_id = ah.id;