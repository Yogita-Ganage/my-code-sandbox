SELECT
    COUNT(*) AS matched_rows
FROM silver_wip_activityheader ah
JOIN silver_staging_completion_status_conformed compconf
ON CONCAT('WIP001', ah.file_number) = compconf.session_care_epi_id;