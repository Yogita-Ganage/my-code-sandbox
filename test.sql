SELECT
    LOWER(TRIM(ws.description)) AS service_description,
    COUNT(*) AS row_count,
    COUNT(DISTINCT ae.activity_header_id) AS case_count
FROM silver_wip_activityentry ae
LEFT JOIN silver_wip_activityservice ads
    ON ae.activity_service_id = ads.id
LEFT JOIN silver_wip_service ws
    ON ads.service_id = ws.id
WHERE LOWER(TRIM(ws.description)) IN (
    'case raised in error',
    'raised in error',
    'bnssg - case raised in error'
)
GROUP BY LOWER(TRIM(ws.description))
ORDER BY case_count DESC;


SELECT
    COUNT(DISTINCT ae.activity_header_id) AS total_inactive_cases
FROM silver_wip_activityentry ae
LEFT JOIN silver_wip_activityservice ads
    ON ae.activity_service_id = ads.id
LEFT JOIN silver_wip_service ws
    ON ads.service_id = ws.id
WHERE LOWER(TRIM(ws.description)) IN (
    'case raised in error',
    'raised in error',
    'bnssg - case raised in error'
);






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