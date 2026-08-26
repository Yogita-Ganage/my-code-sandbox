SELECT DISTINCT
    rota_slot_type
FROM silver_sone_srrotaslot_bridging_to_srappointment
WHERE rota_slot_type IS NOT NULL
ORDER BY rota_slot_type;

SELECT
    rota_slot_type,
    COUNT(*) AS record_count
FROM silver_sone_srrotaslot_bridging_to_srappointment
WHERE rota_slot_type IS NOT NULL
GROUP BY rota_slot_type
ORDER BY rota_slot_type;
