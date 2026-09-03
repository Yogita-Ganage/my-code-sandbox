%%sql

SELECT
    CONCAT('SONE', a.id_organisation_source, CAST(a.id AS STRING)) AS uat_record_id,

    a.rota_type AS appointment_rota_type,
    r.rota_type AS rota_table_rota_type,
    s.rota_slot_type,

    -- OLD cprod_name logic
    LOWER(CONCAT(TRIM(s.rota_slot_type), '_', TRIM(r.rota_type))) AS old_cprod_name,

    -- NEW cprod_name logic
    CONCAT(COALESCE(TRIM(a.rota_type), 'Null'), '_', COALESCE(TRIM(s.rota_slot_type), 'Null')) AS new_cprod_name,

    -- OLD cprod_src_id logic
    CONCAT('SONE', s.id_organisation_source, '_',
           LOWER(CONCAT(TRIM(s.rota_slot_type), '_', TRIM(r.rota_type)))) AS old_cprod_src_id,

    -- NEW mapping for cprod_src_id, but WITHOUT NULL handling
    CONCAT('SONE', a.id_organisation_source, '_',
           LOWER(CONCAT(TRIM(a.rota_type), '_', TRIM(s.rota_slot_type)))) AS new_cprod_src_id_without_null_handling,

    -- NEW mapping for cprod_src_id, using same NULL handling as cprod_name
    CONCAT('SONE', a.id_organisation_source, '_',
           LOWER(CONCAT(
               COALESCE(TRIM(a.rota_type), 'Null'),
               '_',
               COALESCE(TRIM(s.rota_slot_type), 'Null')
           ))) AS new_cprod_src_id_with_null_handling

FROM silver.silver_sone_srappointment a

LEFT JOIN silver.silver_sone_srrota r
    ON a.id_rota = r.id

LEFT JOIN silver.silver_sone_srrotaslot s
    ON a.id_rota = s.id_rota

WHERE CONCAT('SONE', a.id_organisation_source, CAST(a.id AS STRING))
      = 'SONENLF1117057871588';