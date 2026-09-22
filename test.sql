WITH src_mpb_test AS (
    SELECT DISTINCT
        CONCAT('MPB001', ' - ', CAST(t.id AS STRING)) AS service_src_id,
        UPPER(TRIM(t.service_line)) AS service_src_name,
        'MPB001' AS service_src_sys_inst_id
    FROM silver.silver_drj_tenancies t
    WHERE t.service_line IS NOT NULL
      AND TRIM(t.service_line) <> ''
)

SELECT
    service_src_name,
    COUNT(DISTINCT service_src_id) AS id_count
FROM src_mpb_test
GROUP BY service_src_name
ORDER BY id_count DESC;