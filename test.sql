-- Check 1: activity entry -> activity service
SELECT
    COUNT(*) AS total_rows,
    SUM(CASE WHEN ads.id IS NOT NULL THEN 1 ELSE 0 END) AS matched_rows,
    SUM(CASE WHEN ads.id IS NULL THEN 1 ELSE 0 END) AS unmatched_rows
FROM silver_wip_activityentry ae
LEFT JOIN silver_wip_activityservice ads
    ON ae.activity_service_id = ads.id;


-- Check 2: activity service -> service
SELECT
    COUNT(*) AS total_rows,
    SUM(CASE WHEN ws.id IS NOT NULL THEN 1 ELSE 0 END) AS matched_rows,
    SUM(CASE WHEN ws.id IS NULL THEN 1 ELSE 0 END) AS unmatched_rows
FROM silver_wip_activityservice ads
LEFT JOIN silver_wip_service ws
    ON ads.service_id = ws.id;


SELECT
    LOWER(TRIM(ws.description)) AS service_description,
    COUNT(*) AS row_count,
    COUNT(DISTINCT ads.activity_header_id) AS case_count
FROM silver_wip_activityservice ads
LEFT JOIN silver_wip_service ws
    ON ads.service_id = ws.id
WHERE LOWER(TRIM(ws.description)) LIKE '%raised%'
   OR LOWER(TRIM(ws.description)) LIKE '%error%'
GROUP BY LOWER(TRIM(ws.description))
ORDER BY case_count DESC;



LEFT JOIN (
    SELECT
        ads.activity_header_id,
        MAX(
            CASE
                WHEN LOWER(TRIM(ws.description)) IN (
                    'case raised in error',
                    'raised in error',
                    'bnssg - case raised in error'
                )
                THEN 1
                ELSE 0
            END
        ) AS has_case_raised_in_error
    FROM silver_wip_activityservice ads
    LEFT JOIN silver_wip_service ws
        ON ads.service_id = ws.id
    GROUP BY ads.activity_header_id
) wiperr
    ON wiperr.activity_header_id = ah.id