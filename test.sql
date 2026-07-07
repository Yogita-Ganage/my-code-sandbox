SELECT
    ws.description,
    LOWER(TRIM(ws.description)) AS cleaned_description,
    COUNT(*) AS row_count,
    COUNT(DISTINCT ae.activity_header_id) AS activity_header_count
FROM silver_wip_activityentry ae
LEFT JOIN silver_wip_service ws
    ON ae.activity_service_id = ws.id
WHERE LOWER(TRIM(ws.description)) LIKE '%error%'
   OR LOWER(TRIM(ws.description)) LIKE '%raised%'
   OR LOWER(TRIM(ws.description)) LIKE '%bnssg%'
GROUP BY
    ws.description,
    LOWER(TRIM(ws.description))
ORDER BY
    ws.description;



SELECT DISTINCT
    ws.description,
    LOWER(TRIM(ws.description)) AS cleaned_description
FROM silver_wip_activityentry ae
LEFT JOIN silver_wip_service ws
    ON ae.activity_service_id = ws.id
WHERE LOWER(TRIM(ws.description)) LIKE '%error%'
   OR LOWER(TRIM(ws.description)) LIKE '%raised%'
   OR LOWER(TRIM(ws.description)) LIKE '%bnssg%'
ORDER BY
    ws.description;