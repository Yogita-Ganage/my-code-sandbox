-- Get the SONE contract source name using the same source-system-instance mapping used in the RDM Contract ADD logic.
LEFT JOIN silver_rdm_source_system_instance rssi_contr
    ON rssi_contr.src_sys_inst_src_id =
       CONCAT('SONE', CAST(r.id_organisation_source AS STRING))
    AND rssi_contr.src_sys_src_id = 'SONE'

-- Match the RDM contract using both source name and source ID to avoid duplicate matches where the same source name exists more than once.
LEFT JOIN silver_rdm_contract rdmc
    ON TRIM(LOWER(rdmc.contr_src_name))
       = TRIM(LOWER(rssi_contr.src_sys_ins_org_short_name_conformed))
    AND CAST(rdmc.contr_src_id AS VARCHAR(100))
       = CAST(r.id_organisation_source AS VARCHAR(100))