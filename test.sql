SELECT
    z_src_is_active,
    COUNT(*) AS row_count,
    COUNT(DISTINCT care_epi_id) AS distinct_care_episode_count
FROM test_silver_care_episode
WHERE z_src_system_id = 'WIP'
GROUP BY z_src_is_active
ORDER BY z_src_is_active;