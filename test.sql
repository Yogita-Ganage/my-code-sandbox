SELECT
    TRIM(rota_slot_type) AS rota_slot_type,

    CASE
        WHEN LOWER(TRIM(rota_slot_type)) LIKE '%f2f%'
          OR LOWER(TRIM(rota_slot_type)) LIKE '%face to face%'
            THEN 'Face to Face'

        WHEN LOWER(TRIM(rota_slot_type)) LIKE '%telephone%'
          OR LOWER(TRIM(rota_slot_type)) LIKE '%remote%'
            THEN 'Telephone'

        WHEN LOWER(TRIM(rota_slot_type)) LIKE '%video%'
            THEN 'Video'

        ELSE 'Unmapped'
    END AS derived_delivery_method,

    COUNT(*) AS record_count

FROM silver_sone_srrotaslot_bridging_to_srappointment

WHERE rota_slot_type IS NOT NULL

GROUP BY
    TRIM(rota_slot_type),
    CASE
        WHEN LOWER(TRIM(rota_slot_type)) LIKE '%f2f%'
          OR LOWER(TRIM(rota_slot_type)) LIKE '%face to face%'
            THEN 'Face to Face'

        WHEN LOWER(TRIM(rota_slot_type)) LIKE '%telephone%'
          OR LOWER(TRIM(rota_slot_type)) LIKE '%remote%'
            THEN 'Telephone'

        WHEN LOWER(TRIM(rota_slot_type)) LIKE '%video%'
            THEN 'Video'

        ELSE 'Unmapped'
    END

ORDER BY
    derived_delivery_method,
    rota_slot_type;