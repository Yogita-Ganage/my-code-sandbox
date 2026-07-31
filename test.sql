SELECT
    s.id_rota,
    s.id_organisation_source,
    s.rota_slot_type,
    r.rota_type,
    s.blocked_slot,
    CONCAT(
        'SONE',
        s.id_organisation_source,
        '_',
        LOWER(
            CONCAT(
                TRIM(s.rota_slot_type),
                '_',
                TRIM(r.rota_type)
            )
        )
    ) AS generated_cprod_src_id
FROM silver_sone_srrotaslot s
LEFT JOIN silver_sone_srrota r
    ON s.id_rota = r.id
WHERE s.id_organisation_source = '00D1Z'
  AND (
        (
            LOWER(TRIM(s.rota_slot_type)) = 'bromley referral screening'
            AND LOWER(TRIM(r.rota_type)) = 'bromley mcats injection'
        )
        OR
        (
            LOWER(TRIM(s.rota_slot_type)) = 'blocked'
            AND LOWER(TRIM(r.rota_type)) = 'bromley mcats'
        )
      );