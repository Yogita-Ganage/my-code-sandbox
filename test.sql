SELECT
    COUNT(*) AS total_null_rows,
    COUNT(DISTINCT care_epi_id) AS distinct_null_care_epi_ids,
    COUNT(*) - COUNT(DISTINCT care_epi_id) AS extra_duplicate_rows
FROM test_silver_care_episode1
WHERE z_src_system_id = 'MPB'
  AND care_epi_completion_status_conformed IS NULL;