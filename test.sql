SELECT DISTINCT
    a.id_organisation_source,
    a.id_rota,
    r.id AS rota_table_id,
    a.rota_type AS appointment_rota_type,
    r.rota_type AS rota_table_rota_type,
    s.id AS rota_slot_id,
    s.rota_slot_type,
    s.blocked_slot
FROM silver.silver_sone_srappointment a
LEFT JOIN silver.silver_sone_srrota r
    ON a.id_rota = r.id
LEFT JOIN silver.silver_sone_srrotaslot s
    ON a.id_rota = s.id_rota
WHERE CONCAT(
        'SONE',
        a.id_organisation_source,
        '_',
        CAST(a.id_rota AS STRING),
        '_',
        CAST(s.id AS STRING)
      ) = 'SONET7L2F_682116819_616683726845';