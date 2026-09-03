-- SONE: Updated cprod_src_name to use SRAppointment RotaType + SRRotaSlot RotaSlotType, retaining NULL values as 'Null'.

sone_care_product AS (
    SELECT DISTINCT

        CONCAT(COALESCE(TRIM(a.rota_type), 'Null'), '_', COALESCE(TRIM(s.rota_slot_type), 'Null')) AS cprod_name,

        CONCAT('SONE', a.id_organisation_source) AS cprod_src_sys_inst_id,

        CONCAT('SONE', a.id_organisation_source, '_', LOWER(CONCAT(TRIM(s.rota_slot_type), '_', TRIM(r.rota_type)))) AS cprod_src_id

    FROM silver.silver_sone_srappointment a

    LEFT JOIN silver.silver_sone_srrota r
        ON a.id_rota = r.id

    LEFT JOIN silver.silver_sone_srrotaslot s
        ON a.id_rota = s.id_rota

    WHERE a.id IS NOT NULL
      AND a.id_organisation_source IS NOT NULL
),