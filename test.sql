SELECT
    COUNT(*) AS null_rows,
    COUNT(DISTINCT care_epi_id) AS distinct_null_care_episodes
FROM care_epi_ytest
WHERE care_epi_completion_status_conformed IS NULL;

SELECT
    COUNT(DISTINCT CONCAT('WIP001', ah.file_number)) AS distinct_unmatched
FROM silver_wip_activityheader ah
LEFT JOIN silver_staging_completion_status_conformed compconf
    ON CONCAT('WIP001', ah.file_number) = compconf.session_care_epi_id
WHERE compconf.session_care_epi_id IS NULL;