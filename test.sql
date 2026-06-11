SELECT *
FROM silver_drj_users
WHERE to_json(struct(*)) LIKE '%10025127-1%';



SELECT *
FROM silver_drj_users
WHERE to_json(struct(*)) LIKE '%10025127%';
-----

SELECT 'silver_drj_users' AS table_name, COUNT(*) AS matching_rows
FROM silver_drj_users
WHERE to_json(struct(*)) LIKE '%10025127-1%'

UNION ALL

SELECT 'silver_drj_users_restinfo' AS table_name, COUNT(*) AS matching_rows
FROM silver_drj_users_restinfo
WHERE to_json(struct(*)) LIKE '%10025127-1%'

UNION ALL

SELECT 'silver_drj_anamnesises' AS table_name, COUNT(*) AS matching_rows
FROM silver_drj_anamnesises
WHERE to_json(struct(*)) LIKE '%10025127-1%'

UNION ALL

SELECT 'silver_drj_appointments' AS table_name, COUNT(*) AS matching_rows
FROM silver_drj_appointments
WHERE to_json(struct(*)) LIKE '%10025127-1%';

-----

SELECT 'silver_drj_users' AS table_name, COUNT(*) AS matching_rows
FROM silver_drj_users
WHERE to_json(struct(*)) LIKE '%10025127%'

UNION ALL

SELECT 'silver_drj_users_restinfo' AS table_name, COUNT(*) AS matching_rows
FROM silver_drj_users_restinfo
WHERE to_json(struct(*)) LIKE '%10025127%'

UNION ALL

SELECT 'silver_drj_anamnesises' AS table_name, COUNT(*) AS matching_rows
FROM silver_drj_anamnesises
WHERE to_json(struct(*)) LIKE '%10025127%'

UNION ALL

SELECT 'silver_drj_appointments' AS table_name, COUNT(*) AS matching_rows
FROM silver_drj_appointments
WHERE to_json(struct(*)) LIKE '%10025127%';


SELECT
    id,
    group_id,
    reference_id,
    client_reference_number,
    created_at,
    updated_at,
    discharged_at,
    ROW_NUMBER() OVER (
        PARTITION BY reference_id
        ORDER BY created_at ASC
    ) AS possible_suffix
FROM silver_drj_users
WHERE profile_type = 'user'
  AND reference_id = '10025127';