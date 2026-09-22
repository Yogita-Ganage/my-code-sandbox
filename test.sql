SELECT
    COUNT(*) AS total_activity_entries,

    SUM(CASE WHEN ads.id IS NOT NULL THEN 1 ELSE 0 END)
        AS activityservice_matched,

    SUM(CASE WHEN ads.id IS NULL THEN 1 ELSE 0 END)
        AS activityservice_unmatched,

    SUM(CASE WHEN ws.id IS NOT NULL THEN 1 ELSE 0 END)
        AS service_matched,

    SUM(CASE WHEN ws.id IS NULL THEN 1 ELSE 0 END)
        AS service_unmatched

FROM silver_wip_activityentry ae

LEFT JOIN silver_wip_activityservice ads
    ON ae.activity_service_id = ads.id

LEFT JOIN silver_wip_service ws
    ON ads.service_id = ws.id;

WITH wiperr AS (
    SELECT
        ae.activity_header_id,
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

    FROM silver_wip_activityentry ae

    LEFT JOIN silver_wip_activityservice ads
        ON ae.activity_service_id = ads.id

    LEFT JOIN silver_wip_service ws
        ON ads.service_id = ws.id

    GROUP BY ae.activity_header_id
)

SELECT
    CASE
        WHEN wiperr.has_case_raised_in_error = 1 THEN 0
        ELSE 1
    END AS z_src_is_active,
    COUNT(*) AS record_count

FROM silver_wip_activityheader ah

LEFT JOIN wiperr
    ON wiperr.activity_header_id = ah.id

GROUP BY
    CASE
        WHEN wiperr.has_case_raised_in_error = 1 THEN 0
        ELSE 1
    END

ORDER BY z_src_is_active;



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