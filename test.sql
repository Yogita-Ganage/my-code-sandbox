SELECT
    COUNT(*) AS total_rows,

    SUM(
        CASE WHEN ar.user_id IS NULL
        THEN 1 ELSE 0 END
    ) AS null_ar_user_id,

    SUM(
        CASE
            WHEN ar.user_id IS NOT NULL
             AND u.id IS NULL
            THEN 1 ELSE 0
        END
    ) AS user_id_not_found_in_users,

    SUM(
        CASE
            WHEN u.id IS NOT NULL
             AND u.profile_type = 'User'
            THEN 1 ELSE 0
        END
    ) AS matched_profile_type_user,

    SUM(
        CASE
            WHEN u.id IS NOT NULL
             AND COALESCE(u.profile_type, '') <> 'User'
            THEN 1 ELSE 0
        END
    ) AS matched_but_not_profile_type_user

FROM silver_drj_assessment_results ar

LEFT JOIN silver_drj_users u
    ON ar.user_id = u.id;