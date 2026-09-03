SELECT
    id AS activity_header_id,
    file_number AS case_number,
    service_type_id
FROM silver_wip_activityheader
WHERE file_number = 549850;


SELECT
    id AS activity_entry_id,
    activity_header_id,
    activity_service_id,
    activity_type_id
FROM silver_wip_activityentry
WHERE id = 896860;

SELECT
    ae.id AS activity_entry_id,
    ae.activity_header_id AS entry_activity_header_id,
    ah.id AS case_activity_header_id,
    ah.file_number AS case_number,
    ah.service_type_id
FROM silver_wip_activityentry ae
CROSS JOIN silver_wip_activityheader ah
WHERE ae.id = 896860
  AND ah.file_number = 549850;