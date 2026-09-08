CONCAT(
    COALESCE(TRIM(a.rota_type), 'Null'),
    '_',
    COALESCE(TRIM(s.rota_slot_type), 'Null')
) AS cprod_name,

CASE
    WHEN s.blocked_slot = false THEN
        CONCAT(
            'SONE',
            a.id_organisation_source,
            '_',
            CAST(a.id_rota AS STRING),
            '_',
            CAST(s.id AS STRING)
        )
    ELSE NULL
END AS cprod_src_id