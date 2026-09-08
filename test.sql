SELECT
    TRIM(rota_type) AS rota_type,
    TRIM(rota_slot_type) AS rota_slot_type,
    COUNT(DISTINCT cprod_src_id) AS id_count,
    COLLECT_SET(cprod_src_id) AS ids
FROM silver.silver_sone_srrotaslot_bridging_to_srappointment
WHERE cprod_src_id IS NOT NULL
GROUP BY
    TRIM(rota_type),
    TRIM(rota_slot_type)
HAVING COUNT(DISTINCT cprod_src_id) > 1;