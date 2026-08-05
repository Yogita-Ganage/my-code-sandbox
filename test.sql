SELECT
    session_care_epi_id,
    COUNT(*) AS row_count
FROM silver_staging_completion_status_conformed
WHERE session_care_epi_id =
      'MPB9a1f508e-9624-43c5-86ff-7ebc5d8d289e'
GROUP BY session_care_epi_id;