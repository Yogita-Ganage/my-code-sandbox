SELECT DISTINCT
    id_organisation_source,
    rota_type,
    rota_slot_type,
    cprod_src_id,
    id_rota_from_rotaslot
FROM silver.silver_sone_srrotaslot_bridging_to_srappointment
WHERE cprod_src_id IS NOT NULL;


SELECT
    cprod_src_id,
    COUNT(DISTINCT CONCAT_WS(
        '|',
        TRIM(rota_type),
        TRIM(rota_slot_type)
    )) AS name_count,
    COLLECT_SET(CONCAT_WS(
        '_',
        TRIM(rota_type),
        TRIM(rota_slot_type)
    )) AS cprod_names
FROM silver.silver_sone_srrotaslot_bridging_to_srappointment
WHERE cprod_src_id IS NOT NULL
GROUP BY cprod_src_id
HAVING COUNT(DISTINCT CONCAT_WS(
    '|',
    TRIM(rota_type),
    TRIM(rota_slot_type)
)) > 1;