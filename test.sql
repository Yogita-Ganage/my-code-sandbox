SELECT
    id_rota_from_rotaslot,
    COUNT(
        DISTINCT CONCAT(
            LOWER(TRIM(rota_slot_type)),
            ' | ',
            LOWER(TRIM(rota_type))
        )
    ) AS delivery_method_count
FROM silver_sone_srrotaslot_bridging_to_srappointment
WHERE id_rota_from_rotaslot IS NOT NULL
GROUP BY id_rota_from_rotaslot
HAVING COUNT(
        DISTINCT CONCAT(
            LOWER(TRIM(rota_slot_type)),
            ' | ',
            LOWER(TRIM(rota_type))
        )
    ) > 1
ORDER BY delivery_method_count DESC;