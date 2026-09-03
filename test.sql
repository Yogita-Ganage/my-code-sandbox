SELECT DISTINCT
    ah.file_number AS case_number,
    ah.id AS activity_header_id,
    ae.id AS activity_entry_id,
    ah.service_type_id,
    s.id AS service_id,
    at.id AS activity_type_id
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
  AND s.id IS NOT NULL
  AND at.id IS NOT NULL

ORDER BY ah.file_number;