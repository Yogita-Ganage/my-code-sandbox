WITH direct_source AS (
    SELECT DISTINCT
        TRIM(s.rota_slot_type) AS rota_slot_type,
        TRIM(r.rota_type) AS rota_type
    FROM silver_sone_srrotaslot s
    INNER JOIN silver_sone_srrota r
        ON s.id_rota = r.id
       AND s.id_organisation_source = r.id_organisation_source
    WHERE s.rota_slot_type IS NOT NULL
      AND r.rota_type IS NOT NULL
),

bridge_source AS (
    SELECT DISTINCT
        TRIM(rota_slot_type) AS rota_slot_type,
        TRIM(rota_type) AS rota_type
    FROM silver_sone_srrotaslot_bridging_to_srappointment
    WHERE rota_slot_type IS NOT NULL
      AND rota_type IS NOT NULL
)

SELECT *
FROM direct_source

EXCEPT

SELECT *
FROM bridge_source;






WITH direct_source AS (
    SELECT DISTINCT
        TRIM(s.rota_slot_type) AS rota_slot_type,
        TRIM(r.rota_type) AS rota_type
    FROM silver_sone_srrotaslot s
    INNER JOIN silver_sone_srrota r
        ON s.id_rota = r.id
       AND s.id_organisation_source = r.id_organisation_source
    WHERE s.rota_slot_type IS NOT NULL
      AND r.rota_type IS NOT NULL
),

bridge_source AS (
    SELECT DISTINCT
        TRIM(rota_slot_type) AS rota_slot_type,
        TRIM(rota_type) AS rota_type
    FROM silver_sone_srrotaslot_bridging_to_srappointment
    WHERE rota_slot_type IS NOT NULL
      AND rota_type IS NOT NULL
)

SELECT *
FROM bridge_source

EXCEPT

SELECT *
FROM direct_source;