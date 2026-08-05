SELECT
    id,
    reference_id,
    episode_number,
    tenancy_id,
    COUNT(*) AS row_count
FROM silver_drj_users
WHERE profile_type = 'user'
  AND id = '9a1f508e-9624-43c5-86ff-7ebc5d8d289e'
GROUP BY
    id,
    reference_id,
    episode_number,
    tenancy_id;