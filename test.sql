SELECT DISTINCT
    s.id AS rota_slot_id,
    s.id_rota,
    r.id AS rota_id,
    s.id_organisation_source,
    s.rota_slot_type,
    r.rota_type
FROM silver_sone_srrotaslot s
INNER JOIN silver_sone_srrota r
    ON s.id_rota = r.id
   AND s.id_organisation_source = r.id_organisation_source
WHERE s.rota_slot_type IS NOT NULL
  AND r.rota_type IS NOT NULL
ORDER BY s.rota_slot_type, r.rota_type;