SELECT
    id,
    file_number,
    service_type_id
FROM silver_wip_activityheader
WHERE id = 341293;

SELECT *
FROM bronze_wip_activityheader
WHERE Id = 341293;