SELECT
    sra.id,
    CONCAT('SONE', sra.id_organisation, sra.id) AS src_session_id,
    bridgetoapp.cprod_src_id,
    rdmcp.cprod_src_name,
    rdmcp.cprod_id
FROM silver_sone_srappointment sra
LEFT JOIN silver_sone_srrotaslot_bridging_to_srappointment bridgetoapp
    ON CONCAT('SONE', sra.id_organisation, sra.id)
       = bridgetoapp.src_session_id
   AND sra.id_organisation = bridgetoapp.id_organisation_source
LEFT JOIN silver_rdm_care_product rdmcp
    ON LOWER(TRIM(rdmcp.cprod_src_id))
       = LOWER(TRIM(bridgetoapp.cprod_src_id))
WHERE CONCAT('SONE', sra.id_organisation, sra.id_patient)
      = 'SONE00D1260771749';