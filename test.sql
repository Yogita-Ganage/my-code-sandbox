SELECT
    z_src_system_id,
    COUNT(*) AS total_count,
    SUM(
        CASE
            WHEN care_epi_completion_status_conformed IS NULL THEN 1
            ELSE 0
        END
    ) AS null_count,
    SUM(
        CASE
            WHEN care_epi_completion_status_conformed = 0 THEN 1
            ELSE 0
        END
    ) AS zero_count,
    SUM(
        CASE
            WHEN care_epi_completion_status_conformed = 1 THEN 1
            ELSE 0
        END
    ) AS one_count
FROM test_silver_care_episode1
GROUP BY z_src_system_id
ORDER BY z_src_system_id;


SELECT
    session_care_epi_id,
    care_epi_completion_status_conformed
FROM test_silver_staging_completion_status_conformed
WHERE session_care_epi_id LIKE 'MPB%'
LIMIT 20;