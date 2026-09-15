%%sql

WITH dup_keys AS (

    SELECT
        LOWER(TRIM(cprod_src_sys_inst_src_id)) AS src_instance,
        LOWER(TRIM(cprod_src_id)) AS normalized_cprod_src_id

    FROM silver_rdm_care_product

    WHERE LOWER(TRIM(cprod_src_sys_inst_src_id)) LIKE 'sone%'

    GROUP BY
        LOWER(TRIM(cprod_src_sys_inst_src_id)),
        LOWER(TRIM(cprod_src_id))

    HAVING COUNT(*) > 1
)

SELECT
    r.cprod_id,
    r.cprod_src_name,
    r.cprod_src_sys_inst_src_id,
    r.cprod_src_id,

    r.cprod_type_conformed,
    r.cprod_group_conformed,
    r.cprod_service_id,
    r.cprod_is_assessment,
    r.cprod_is_treatment,

    r.z_src_created_date_time,
    r.z_src_created_by_user,
    r.z_src_modified_date_time,
    r.z_src_modified_by_user

FROM silver_rdm_care_product r

INNER JOIN dup_keys d
    ON LOWER(TRIM(r.cprod_src_sys_inst_src_id)) = d.src_instance
   AND LOWER(TRIM(r.cprod_src_id)) = d.normalized_cprod_src_id

ORDER BY
    d.src_instance,
    d.normalized_cprod_src_id,
    r.z_src_created_date_time,
    r.cprod_id;