SELECT
    care_epi_id,
    care_epi_number,
    COUNT(*) AS row_count
FROM silver_care_episode_ytest
WHERE z_src_system_id = 'MPB'
GROUP BY
    care_epi_id,
    care_epi_number
HAVING COUNT(*) > 1
ORDER BY row_count DESC;

SELECT *
FROM silver_care_episode_ytest
WHERE care_epi_id = 'MPB0019a1f508e-9624-43c5-86ff-7ebc5d8d289e';