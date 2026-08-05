SELECT
    pw.user_id,
    pw.pathway,
    rdmpwc.care_epi_pathway,
    rdmpwc.z_src_system_id,
    COUNT(*) AS match_count
FROM silver_staging_mpb_pathway pw

LEFT JOIN silver_rdm_pathway rdmpwc
    ON TRIM(LOWER(rdmpwc.care_epi_pathway))
       = TRIM(LOWER(pw.pathway))
   AND rdmpwc.z_src_system_id = 'MPB'

WHERE pw.user_id = '9a1f508e-9624-43c5-86ff-7ebc5d8d289e'
  AND pw.change_num_desc = 1

GROUP BY
    pw.user_id,
    pw.pathway,
    rdmpwc.care_epi_pathway,
    rdmpwc.z_src_system_id;