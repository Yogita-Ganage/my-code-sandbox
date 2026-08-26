sone_source AS (

    SELECT DISTINCT
        CONCAT('SONE', s.id_organisation_source, '_', LOWER(CONCAT(TRIM(s.rota_slot_type), ' - ', TRIM(r.rota_type)))) AS del_meth_src_id,
        CONCAT('SONE', s.id_organisation_source) AS del_meth_src_sys_inst_id,
        CONCAT(TRIM(s.rota_slot_type), ' - ', TRIM(r.rota_type)) AS del_meth_src_name

    FROM silver_sone_srrotaslot s

    LEFT JOIN silver_sone_srrota r
        ON s.id_rota = r.id
        AND s.id_organisation_source = r.id_organisation_source

    WHERE s.rota_slot_type IS NOT NULL
      AND r.rota_type IS NOT NULL
)


Logic:

del_meth_src_name = rota_slot_type + rota_type
del_meth_src_id = SONE + organisation source + rota_slot_type + rota_type
del_meth_src_sys_inst_id = SONE + id_organisation_source