SELECT DISTINCT
    s.rota_slot_type,
    r.rota_type,
    s.blocked_slot
FROM silver_sone_srrotaslot s
LEFT JOIN silver_sone_srrota r
    ON s.id_rota = r.id
WHERE LOWER(TRIM(s.rota_slot_type)) = 'bromley referral screening'
  AND LOWER(TRIM(r.rota_type)) = 'bromley mcats injection';