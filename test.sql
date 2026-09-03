%%sql

SELECT
    CONCAT('SONE', a.id_organisation_source, CAST(a.id AS STRING)) AS uat_record_id,

    a.id,
    a.id_organisation_source,
    a.id_rota,

    -- Definition says RotaType comes from SRAppointment
    a.rota_type AS appointment_rota_type,

    -- Current code is taking rota_type from SRRota
    r.rota_type AS current_code_rota_type,

    s.rota_slot_type,

    -- Value as per current implementation
    LOWER(
        CONCAT(
            TRIM(s.rota_slot_type),
            '_',
            TRIM(r.rota_type)
        )
    ) AS current_code_cprod_name,

    -- Value following UAT/definition behaviour
    CONCAT(
        COALESCE(TRIM(a.rota_type), 'Null'),
        '_',
        COALESCE(TRIM(s.rota_slot_type), 'Null')
    ) AS expected_cprod_src_name

FROM silver.silver_sone_srappointment a

LEFT JOIN silver.silver_sone_srrota r
    ON a.id_rota = r.id

LEFT JOIN silver.silver_sone_srrotaslot s
    ON a.id_rota = s.id_rota

WHERE CONCAT(
        'SONE',
        a.id_organisation_source,
        CAST(a.id AS STRING)
      ) = 'SONENLF1117057871588';