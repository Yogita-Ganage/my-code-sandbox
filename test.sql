COALESCE(
    ccompconf.care_epi_completion_status_conformed,
    0
) AS care_epi_completion_status_conformed




SELECT
    care_epi_completion_status_conformed,
    COUNT(*) AS count
FROM test_silver_care_episode1
WHERE z_src_system_id = 'MPB'
GROUP BY care_epi_completion_status_conformed
ORDER BY care_epi_completion_status_conformed;