%%sql

DROP TABLE IF EXISTS test_sone_care_product;

CREATE TABLE test_sone_care_product AS

SELECT DISTINCT

    a.id AS appointment_id,
    a.id_organisation_source,
    a.id_rota,

    -- Raw values for validation
    a.rota_type AS appointment_rota_type,
    s.id AS rota_slot_id,
    s.rota_slot_type,
    s.blocked_slot,
    r.id AS rota_id,
    r.rota_type AS rota_table_rota_type,

    -- Updated cprod_src_name logic
    CONCAT(
        COALESCE(TRIM(a.rota_type), 'Null'),
        '_',
        COALESCE(TRIM(s.rota_slot_type), 'Null')
    ) AS cprod_name,

    CONCAT('SONE', a.id_organisation_source) AS cprod_src_sys_inst_id,

    -- cprod_src_id using corresponding IDs from the definition
    CONCAT(
        'SONE',
        a.id_organisation_source,
        '_',
        CAST(s.id AS STRING),
        '_',
        CAST(r.id AS STRING)
    ) AS cprod_src_id

FROM silver.silver_sone_srappointment a

LEFT JOIN silver.silver_sone_srrota r
    ON a.id_rota = r.id

LEFT JOIN silver.silver_sone_srrotaslot s
    ON a.id_rota = s.id_rota
    AND s.blocked_slot = 0

WHERE a.id IS NOT NULL
  AND a.id_organisation_source IS NOT NULL;


  %%sql

SELECT *
FROM test_sone_care_product
WHERE CONCAT(
        'SONE',
        id_organisation_source,
        CAST(appointment_id AS STRING)
      ) = 'SONENLF1117057871588';



%%sql

SELECT
    COUNT(*) AS total_count,
    SUM(CASE WHEN cprod_src_id IS NULL THEN 1 ELSE 0 END) AS null_cprod_src_id,
    SUM(CASE WHEN cprod_src_id IS NOT NULL THEN 1 ELSE 0 END) AS not_null_cprod_src_id
FROM test_sone_care_product;