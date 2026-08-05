SELECT *
FROM silver_rdm_pathway
WHERE z_src_system_id = 'MPB'
  AND TRIM(LOWER(care_epi_pathway)) = 'high intensity (cbt)';