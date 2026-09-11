WITH base AS (
    SELECT
        ae.id AS session_id,
        AHRD.customer_id,
        AHRD.customer_name
    FROM silver_wip_activityentry ae
    LEFT JOIN silver_wip_activityheader ah
        ON ae.activity_header_id = ah.id
    LEFT JOIN silver_wip_activityheaderroledetail AHRD
        ON ah.id = AHRD.activity_header_id
),

-- 1. OLD: Name only
old_name_join AS (
    SELECT
        b.session_id,
        org.id AS organisation_id
    FROM base b
    LEFT JOIN silver_wip_organisation org
        ON LOWER(TRIM(org.name)) = LOWER(TRIM(b.customer_name))
),

-- 2. NEW: ID only
new_id_join AS (
    SELECT
        b.session_id,
        org.id AS organisation_id
    FROM base b
    LEFT JOIN silver_wip_businessrole cust_br
        ON cust_br.id = b.customer_id
    LEFT JOIN silver_wip_organisation org
        ON org.id = cust_br.business_actor_id
),

-- 3. NEW: ID + Name
new_id_name_join AS (
    SELECT
        b.session_id,
        org.id AS organisation_id
    FROM base b
    LEFT JOIN silver_wip_businessrole cust_br
        ON cust_br.id = b.customer_id
    LEFT JOIN silver_wip_organisation org
        ON org.id = cust_br.business_actor_id
       AND LOWER(TRIM(org.name)) = LOWER(TRIM(b.customer_name))
),

combined AS (
    SELECT '1_OLD_NAME_ONLY' AS join_type, * FROM old_name_join
    UNION ALL
    SELECT '2_NEW_ID_ONLY' AS join_type, * FROM new_id_join
    UNION ALL
    SELECT '3_NEW_ID_AND_NAME' AS join_type, * FROM new_id_name_join
)

SELECT
    join_type,

    COUNT(*) AS total_joined_rows,

    COUNT(DISTINCT session_id) AS distinct_sessions,

    COUNT(DISTINCT CASE
        WHEN organisation_id IS NOT NULL THEN session_id
    END) AS matched_sessions,

    COUNT(DISTINCT CASE
        WHEN organisation_id IS NULL THEN session_id
    END) AS unmatched_sessions,

    COUNT(*) - COUNT(DISTINCT session_id) AS extra_rows

FROM combined
GROUP BY join_type
ORDER BY join_type;