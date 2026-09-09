SELECT
    a.id_organisation_source,
    COUNT(DISTINCT a.id) AS record_count
FROM silver.silver_sone_srappointment a

LEFT JOIN silver.silver_sone_srrotaslot s
    ON a.id_rota = s.id_rota

WHERE a.id IS NOT NULL
  AND a.id_organisation_source IS NOT NULL
  AND COALESCE(TRIM(a.rota_type), '') = ''
  AND COALESCE(TRIM(s.rota_slot_type), '') = ''

GROUP BY
    a.id_organisation_source

ORDER BY
    a.id_organisation_source;