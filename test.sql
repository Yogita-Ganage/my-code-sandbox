SELECT
    u.id AS user_id,
    serv.value AS source_service_value,
    pserv.care_epi_primary_service_requested,
    COUNT(*) AS match_count
FROM silver_drj_users u

LEFT JOIN (
    SELECT
        user_id,
        title,
        updated_at,
        value,
        ROW_NUMBER() OVER (
            PARTITION BY user_id
            ORDER BY updated_at DESC
        ) AS rowno
    FROM silver_drj_anamnesises_epicrisis
    WHERE title = 'Treatment Type'
) serv
    ON serv.user_id = u.id
   AND serv.rowno = 1

LEFT JOIN silver_rdm_care_episode_primary_service pserv
    ON pserv.care_epi_primary_service_requested = serv.value
   AND pserv.z_src_system_id = 'MPB'

WHERE u.profile_type = 'user'
  AND u.id = '9a1f508e-9624-43c5-86ff-7ebc5d8d289e'

GROUP BY
    u.id,
    serv.value,
    pserv.care_epi_primary_service_requested;