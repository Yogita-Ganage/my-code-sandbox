SELECT
    COUNT(*) AS total_rows,
    SUM(CASE WHEN care_epi_number IS NULL OR TRIM(care_epi_number) = '' THEN 1 ELSE 0 END) AS blank_count,
    SUM(CASE WHEN care_epi_number IS NOT NULL AND TRIM(care_epi_number) <> '' THEN 1 ELSE 0 END) AS populated_count
FROM <>;



SELECT
    COUNT(*) AS total_rows,
    SUM(CASE WHEN reference_id IS NULL THEN 1 ELSE 0 END) AS null_reference_id,
    SUM(CASE WHEN episode_number IS NULL THEN 1 ELSE 0 END) AS null_episode_number
FROM silver_drj_users
WHERE profile_type = 'user';