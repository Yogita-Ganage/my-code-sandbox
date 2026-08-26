SELECT DISTINCT
    s.rota_slot_type,
    r.rota_type,
    CONCAT(TRIM(s.rota_slot_type), ' - ', TRIM(r.rota_type)) AS del_meth_src_name
FROM silver_sone_srrotaslot s
LEFT JOIN silver_sone_srrota r
    ON s.id_rota = r.id
    AND s.id_organisation_source = r.id_organisation_source
WHERE s.rota_slot_type IS NOT NULL
  AND r.rota_type IS NOT NULL
  AND (
       LOWER(CONCAT(s.rota_slot_type, ' ', r.rota_type)) LIKE '%face%'
    OR LOWER(CONCAT(s.rota_slot_type, ' ', r.rota_type)) LIKE '%f2f%'
    OR LOWER(CONCAT(s.rota_slot_type, ' ', r.rota_type)) LIKE '%telephone%'
    OR LOWER(CONCAT(s.rota_slot_type, ' ', r.rota_type)) LIKE '%video%'
  )
ORDER BY del_meth_src_name;