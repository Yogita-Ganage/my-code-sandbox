SELECT
    COUNT(*) AS total_records,
    COUNT(rdmcp.cprod_src_id) AS matched_records,
    COUNT(*) - COUNT(rdmcp.cprod_src_id) AS unmatched_records
FROM silver_sone_srappointment sra
LEFT JOIN silver_sone_srrota srro
    ON srro.id = sra.id_rota
   AND srro.id_organisation_source = sra.id_organisation
LEFT JOIN silver_sone_srrotaslot_bridging_to_srappointment br
    ON CONCAT('SONE', sra.id_organisation, sra.id) = br.src_session_id
   AND br.id_organisation_source = sra.id_organisation
LEFT JOIN silver_rdm_care_product rdmcp
    ON LOWER(TRIM(rdmcp.cprod_src_id))
       = LOWER(TRIM(br.cprod_src_id));


SELECT
    COUNT(*) AS total_records,
    COUNT(rdmcp.cprod_src_id) AS matched_records,
    COUNT(*) - COUNT(rdmcp.cprod_src_id) AS unmatched_records
FROM silver_sone_srappointment sra
LEFT JOIN silver_sone_srrota srro
    ON srro.id = sra.id_rota
   AND srro.id_organisation_source = sra.id_organisation
LEFT JOIN silver_sone_srrotaslot srslot
    ON srslot.id_rota = sra.id_rota
   AND srslot.id_organisation_source = sra.id_organisation
LEFT JOIN silver_rdm_care_product rdmcp
    ON LOWER(TRIM(rdmcp.cprod_src_id)) =
       LOWER(TRIM(CONCAT(
           'SONE',
           sra.id_organisation,
           '-',
           LOWER(CONCAT(TRIM(srslot.rota_slot_type), '-', TRIM(srro.rota_type)))
       )));