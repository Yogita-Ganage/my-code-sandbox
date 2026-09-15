%%sql

SELECT
    LOWER(TRIM(cprod_src_sys_inst_src_id)) AS src_instance,
    LOWER(TRIM(cprod_src_id)) AS normalized_cprod_src_id,

    COUNT(*) AS row_cnt,
    COUNT(DISTINCT cprod_src_id) AS original_variant_cnt,

    COLLECT_SET(cprod_id) AS cprod_ids,
    COLLECT_SET(cprod_src_id) AS original_values,

    MIN(z_src_created_date_time) AS first_created_date,
    MAX(z_src_created_date_time) AS latest_created_date,

    COLLECT_SET(z_src_created_by_user) AS created_by_users,
    COLLECT_SET(z_src_modified_by_user) AS modified_by_users

FROM silver_rdm_care_product

WHERE LOWER(TRIM(cprod_src_sys_inst_src_id)) LIKE 'sone%'

GROUP BY
    LOWER(TRIM(cprod_src_sys_inst_src_id)),
    LOWER(TRIM(cprod_src_id))

HAVING COUNT(*) > 1

ORDER BY latest_created_date DESC;