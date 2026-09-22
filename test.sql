WITH header_check AS (
    SELECT
        ae.activity_header_id,
        COUNT(*) AS entry_count,

        SUM(
            CASE
                WHEN LOWER(TRIM(ws.description)) IN (
                    'case raised in error',
                    'raised in error',
                    'bnssg - case raised in error'
                )
                THEN 1
                ELSE 0
            END
        ) AS raised_error_entries,

        SUM(
            CASE
                WHEN LOWER(TRIM(ws.description)) NOT IN (
                    'case raised in error',
                    'raised in error',
                    'bnssg - case raised in error'
                )
                OR ws.description IS NULL
                THEN 1
                ELSE 0
            END
        ) AS normal_entries

    FROM silver_wip_activityentry ae

    LEFT JOIN silver_wip_activityservice ads
        ON ae.activity_service_id = ads.id

    LEFT JOIN silver_wip_service ws
        ON ads.service_id = ws.id

    GROUP BY ae.activity_header_id
)

SELECT
    SUM(CASE WHEN entry_count > 1 THEN 1 ELSE 0 END)
        AS headers_with_multiple_entries,

    SUM(
        CASE
            WHEN raised_error_entries > 0
             AND normal_entries > 0
            THEN 1
            ELSE 0
        END
    ) AS headers_with_mixed_entries

FROM header_check;