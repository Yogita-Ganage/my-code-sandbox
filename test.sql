SELECT DISTINCT
    r.id_organisation_source AS care_epi_src_id,
    rssi_contr.src_sys_ins_org_short_name_conformed AS care_epi_src_name,
    rdmc.contr_src_id AS rdm_src_id,
    rdmc.contr_src_name AS rdm_src_name,
    rdmc.contr_id
FROM silver_sone_srreferralin r

LEFT JOIN silver_rdm_source_system_instance rssi_contr
    ON rssi_contr.src_sys_inst_src_id =
       CONCAT('SONE', CAST(r.id_organisation_source AS STRING))
    AND rssi_contr.src_sys_src_id = 'SONE'

LEFT JOIN silver_rdm_contract rdmc
    ON TRIM(LOWER(rdmc.contr_src_name))
       = TRIM(LOWER(rssi_contr.src_sys_ins_org_short_name_conformed))

WHERE rdmc.contr_id IS NOT NULL
ORDER BY r.id_organisation_source;