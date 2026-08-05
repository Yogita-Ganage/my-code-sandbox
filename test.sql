SELECT
    care_epi_pathway,
    care_epi_pathway_conformed,
    z_record_created_date_time,
    z_record_modified_date_time,
    z_record_created_by_user,
    z_record_modified_by_user
FROM silver_rdm_pathway
WHERE z_src_system_id = 'MPB'
  AND TRIM(LOWER(care_epi_pathway)) = 'high intensity (cbt)'
ORDER BY z_record_modified_date_time DESC;