%%sql

WITH duplicate_groups AS (

    SELECT
        LOWER(TRIM(cprod_src_sys_inst_src_id)) AS src_instance,
        LOWER(TRIM(cprod_src_id)) AS normalized_cprod_src_id,
        COUNT(*) AS cnt

    FROM silver_rdm_care_product

    WHERE LOWER(TRIM(cprod_src_sys_inst_src_id)) LIKE 'sone%'

    GROUP BY
        LOWER(TRIM(cprod_src_sys_inst_src_id)),
        LOWER(TRIM(cprod_src_id))

    HAVING COUNT(*) > 1
)

SELECT
    COUNT(*) AS duplicate_groups,
    SUM(cnt - 1) AS extra_rows_to_review
FROM duplicate_groups;