LEFT JOIN (
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

) wiperr
    ON wiperr.activity_header_id = ah.id



SELECT
    z_src_is_active,
    COUNT(*) AS record_count
FROM test_silver_care_episode
WHERE z_src_system_id = 'WIP'
GROUP BY z_src_is_active
ORDER BY z_src_is_active;


SELECT DISTINCT
    t.care_epi_id,
    t.z_src_is_active,
    LOWER(TRIM(ws.description)) AS service_description
FROM test_silver_care_episode t
JOIN silver_wip_activityheader ah
    ON t.care_epi_src_id = ah.file_number
JOIN silver_wip_activityentry ae
    ON ae.activity_header_id = ah.id
JOIN silver_wip_activityservice ads
    ON ae.activity_service_id = ads.id
JOIN silver_wip_service ws
    ON ads.service_id = ws.id
WHERE t.z_src_system_id = 'WIP'
  AND t.z_src_is_active = 0
  AND LOWER(TRIM(ws.description)) IN (
      'case raised in error',
      'raised in error',
      'bnssg - case raised in error'
  )
LIMIT 50;


SELECT COUNT(*) AS incorrect_inactive_records
FROM test_silver_care_episode t
WHERE t.z_src_system_id = 'WIP'
  AND t.z_src_is_active = 0
  AND NOT EXISTS (
      SELECT 1
      FROM silver_wip_activityheader ah
      JOIN silver_wip_activityentry ae
          ON ae.activity_header_id = ah.id
      JOIN silver_wip_activityservice ads
          ON ae.activity_service_id = ads.id
      JOIN silver_wip_service ws
          ON ads.service_id = ws.id
      WHERE ah.file_number = t.care_epi_src_id
        AND LOWER(TRIM(ws.description)) IN (
            'case raised in error',
            'raised in error',
            'bnssg - case raised in error'
        )
  );