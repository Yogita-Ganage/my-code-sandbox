SELECT
    u.id AS user_id,
    src.value AS source_referral_value,
    refs.care_epi_referral_source,
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
    WHERE title = 'Referral Source'
) src
    ON src.user_id = u.id
   AND src.rowno = 1

LEFT JOIN silver_rdm_referral_source refs
    ON TRIM(LOWER(refs.care_epi_referral_source)) =
       TRIM(LOWER(src.value))
   AND refs.z_src_system_id = 'MPB'

WHERE u.profile_type = 'user'
  AND u.id = '9a1f508e-9624-43c5-86ff-7ebc5d8d289e'

GROUP BY
    u.id,
    src.value,
    refs.care_epi_referral_source;