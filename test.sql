WITH current_name AS (
    SELECT DISTINCT
        a.id_organisation_source,
        TRIM(a.rota_type) AS rota_type,
        TRIM(s.rota_slot_type) AS rota_slot_type
    FROM silver.silver_sone_srappointment a
    LEFT JOIN silver.silver_sone_srrotaslot s
        ON a.id_rota = s.id_rota
    WHERE a.id IS NOT NULL
      AND a.id_organisation_source IS NOT NULL
),

bridge_name AS (
    SELECT DISTINCT
        b.id_organisation_source,
        TRIM(b.rota_type) AS rota_type,
        TRIM(b.rota_slot_type) AS rota_slot_type
    FROM silver.silver_sone_srrotaslot_bridging_to_srappointment b
)

SELECT c.*
FROM current_name c
LEFT ANTI JOIN bridge_name b
    ON c.id_organisation_source = b.id_organisation_source
   AND LOWER(c.rota_type) <=> LOWER(b.rota_type)
   AND LOWER(c.rota_slot_type) <=> LOWER(b.rota_slot_type);





WITH current_name AS (
    SELECT DISTINCT
        a.id_organisation_source,
        TRIM(a.rota_type) AS rota_type,
        TRIM(s.rota_slot_type) AS rota_slot_type
    FROM silver.silver_sone_srappointment a
    LEFT JOIN silver.silver_sone_srrotaslot s
        ON a.id_rota = s.id_rota
    WHERE a.id IS NOT NULL
      AND a.id_organisation_source IS NOT NULL
),

bridge_name AS (
    SELECT DISTINCT
        b.id_organisation_source,
        TRIM(b.rota_type) AS rota_type,
        TRIM(b.rota_slot_type) AS rota_slot_type
    FROM silver.silver_sone_srrotaslot_bridging_to_srappointment b
)

SELECT b.*
FROM bridge_name b
LEFT ANTI JOIN current_name c
    ON c.id_organisation_source = b.id_organisation_source
   AND LOWER(c.rota_type) <=> LOWER(b.rota_type)
   AND LOWER(c.rota_slot_type) <=> LOWER(b.rota_slot_type);