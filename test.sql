SELECT
    CONCAT(
        'SONE',
        a.id_organisation_source,
        '_',
        CAST(a.id_rota AS STRING),
        '_',
        CAST(s.id AS STRING)
    ) AS cprod_src_id,

    s.blocked_slot,

    COUNT(DISTINCT TRIM(a.rota_type)) AS rota_type_count,

    COLLECT_SET(TRIM(a.rota_type)) AS rota_types

FROM silver.silver_sone_srappointment a

LEFT JOIN silver.silver_sone_srrotaslot s
    ON a.id_rota = s.id_rota

WHERE a.id IS NOT NULL
  AND a.id_organisation_source IS NOT NULL

GROUP BY
    a.id_organisation_source,
    a.id_rota,
    s.id,
    s.blocked_slot

HAVING COUNT(DISTINCT TRIM(a.rota_type)) > 1;