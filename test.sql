WITH current_name AS (
    SELECT DISTINCT
        a.id_organisation_source,
        CONCAT(
            COALESCE(TRIM(a.rota_type), 'Null'),
            '_',
            COALESCE(TRIM(s.rota_slot_type), 'Null')
        ) AS cprod_name
    FROM silver.silver_sone_srappointment a
    LEFT JOIN silver.silver_sone_srrotaslot s
        ON a.id_rota = s.id_rota
    WHERE a.id IS NOT NULL
      AND a.id_organisation_source IS NOT NULL
),

bridge_name AS (
    SELECT DISTINCT
        b.id_organisation_source,
        CONCAT(
            COALESCE(TRIM(b.rota_type), 'Null'),
            '_',
            COALESCE(TRIM(b.rota_slot_type), 'Null')
        ) AS cprod_name
    FROM silver.silver_sone_srrotaslot_bridging_to_srappointment b
)

SELECT
    'current' AS source,
    COUNT(*) AS cnt
FROM current_name

UNION ALL

SELECT
    'bridge' AS source,
    COUNT(*) AS cnt
FROM bridge_name;