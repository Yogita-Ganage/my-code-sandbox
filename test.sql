%%sql

DROP TABLE IF EXISTS zz_test_sone_del_meth_src_id;

CREATE TABLE zz_test_sone_del_meth_src_id AS

SELECT
    appointment_id,
    id_organisation_source,
    del_meth_src_sys_inst_id,
    del_meth_src_name,

    CONCAT(
        'SONE',
        id_organisation_source,
        '_',
        LOWER(TRIM(del_meth_src_name))
    ) AS del_meth_src_id

FROM zz_test_sone_del_meth_src_name;




SELECT
    appointment_id,
    del_meth_src_sys_inst_id,
    del_meth_src_name,
    del_meth_src_id
FROM zz_test_sone_del_meth_src_id
LIMIT 50;


SELECT
    del_meth_src_sys_inst_id,
    del_meth_src_id,
    COUNT(DISTINCT del_meth_src_name) AS name_count
FROM zz_test_sone_del_meth_src_id
GROUP BY
    del_meth_src_sys_inst_id,
    del_meth_src_id
HAVING COUNT(DISTINCT del_meth_src_name) > 1;


SELECT
    del_meth_src_sys_inst_id,
    del_meth_src_name,
    COUNT(DISTINCT del_meth_src_id) AS id_count
FROM zz_test_sone_del_meth_src_id
GROUP BY
    del_meth_src_sys_inst_id,
    del_meth_src_name
HAVING COUNT(DISTINCT del_meth_src_id) > 1;


SELECT
    COUNT(*) AS total_rows,

    SUM(
        CASE
            WHEN del_meth_src_id IS NULL
              OR TRIM(del_meth_src_id) = ''
            THEN 1 ELSE 0
        END
    ) AS null_del_meth_src_id

FROM zz_test_sone_del_meth_src_id;