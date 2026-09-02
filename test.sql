SELECT
    s.id_organisation_source,
    TRIM(s.rota_slot_type) AS rota_slot_type,
    TRIM(r.rota_type) AS rota_type,

    COUNT(DISTINCT s.id) AS distinct_rota_slot_ids,
    COUNT(DISTINCT r.id) AS distinct_rota_ids

FROM silver_sone_srrotaslot s
INNER JOIN silver_sone_srrota r
    ON s.id_rota = r.id
   AND s.id_organisation_source = r.id_organisation_source

WHERE s.rota_slot_type IS NOT NULL
  AND r.rota_type IS NOT NULL

GROUP BY
    s.id_organisation_source,
    TRIM(s.rota_slot_type),
    TRIM(r.rota_type)

HAVING COUNT(DISTINCT s.id) > 1
    OR COUNT(DISTINCT r.id) > 1

ORDER BY distinct_rota_slot_ids DESC;