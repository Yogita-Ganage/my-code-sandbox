-- Check how many activity_service_id values actually match silver_wip_service
SELECT
    COUNT(*) AS total_activity_entries,
    SUM(CASE WHEN ws.id IS NOT NULL THEN 1 ELSE 0 END) AS matched_rows,
    SUM(CASE WHEN ws.id IS NULL THEN 1 ELSE 0 END) AS unmatched_rows
FROM silver_wip_activityentry ae
LEFT JOIN silver_wip_service ws
    ON ae.activity_service_id = ws.id;



-- Check all descriptions containing "raised" / "error"
SELECT
    LOWER(TRIM(ws.description)) AS service_description,
    COUNT(*) AS row_count,
    COUNT(DISTINCT ae.activity_header_id) AS case_count
FROM silver_wip_activityentry ae
LEFT JOIN silver_wip_service ws
    ON ae.activity_service_id = ws.id
WHERE LOWER(TRIM(ws.description)) LIKE '%raised%'
   OR LOWER(TRIM(ws.description)) LIKE '%error%'
GROUP BY LOWER(TRIM(ws.description))
ORDER BY case_count DESC;



DESCRIBE silver_wip_activityservice;