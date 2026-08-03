SELECT
    COUNT(*) AS total,
    COUNT(compconf.session_care_epi_id) AS matched,
    COUNT(*) - COUNT(compconf.session_care_epi_id) AS unmatched
FROM silver_wip_activityheader ah
LEFT JOIN silver_staging_completion_status_conformed compconf
    ON CONCAT('WIP001', ah.file_number) = compconf.session_care_epi_id;