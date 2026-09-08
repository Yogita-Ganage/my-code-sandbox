SELECT DISTINCT
    r.id_organisation_source,
    rssi_contr.src_sys_inst_src_id,
    rssi_contr.src_sys_ins_org_short_name_conformed
FROM silver_sone_srreferralin r
LEFT JOIN silver_rdm_source_system_instance rssi_contr
    ON rssi_contr.src_sys_inst_src_id =
       CONCAT('SONE', CAST(r.id_organisation_source AS STRING))
    AND rssi_contr.src_sys_src_id = 'SONE'
ORDER BY r.id_organisation_source;