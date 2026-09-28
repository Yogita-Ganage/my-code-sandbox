%%sql

DROP TABLE IF EXISTS zz_test_sone_del_meth_src_name;

CREATE TABLE zz_test_sone_del_meth_src_name AS

WITH sone_appointment_flags AS
(
    SELECT
        af.id_appointment,
        af.id_organisation_source,

        CONCAT_WS(
            '_',
            SORT_ARRAY(
                COLLECT_SET(TRIM(m.mapping))
            )
        ) AS flag_mappings

    FROM silver_sone_srappointmentflags af

    LEFT JOIN silver_sone_srmapping m
        ON af.flag = m.id
        AND af.id_organisation_source = m.id_organisation_source

    GROUP BY
        af.id_appointment,
        af.id_organisation_source
)

SELECT
    a.id AS appointment_id,
    a.id_organisation_source,
    CONCAT('SONE', a.id_organisation_source) AS del_meth_src_sys_inst_id,

    a.rota_type,
    f.flag_mappings,

    CONCAT_WS(
        '_',
        TRIM(a.rota_type),
        f.flag_mappings
    ) AS del_meth_src_name

FROM silver_sone_srappointment a

LEFT JOIN sone_appointment_flags f
    ON a.id = f.id_appointment
    AND a.id_organisation_source = f.id_organisation_source

WHERE a.rota_type IS NOT NULL;



SELECT
    COUNT(*) AS total_rows,
    COUNT(DISTINCT appointment_id, id_organisation_source) AS distinct_appointments
FROM zz_test_sone_del_meth_src_name;


SELECT
    appointment_id,
    id_organisation_source,
    COUNT(*) AS duplicate_count
FROM zz_test_sone_del_meth_src_name
GROUP BY
    appointment_id,
    id_organisation_source
HAVING COUNT(*) > 1
ORDER BY duplicate_count DESC;

SELECT
    COUNT(*) AS total_rows,

    SUM(
        CASE WHEN del_meth_src_name IS NULL
                  OR TRIM(del_meth_src_name) = ''
             THEN 1 ELSE 0 END
    ) AS null_del_meth_src_name,

    SUM(
        CASE WHEN rota_type IS NULL
             THEN 1 ELSE 0 END
    ) AS null_rota_type,

    SUM(
        CASE WHEN flag_mappings IS NULL
             THEN 1 ELSE 0 END
    ) AS no_flag_records

FROM zz_test_sone_del_meth_src_name;





SELECT
    id_organisation_source,
    del_meth_src_name,
    COUNT(*) AS record_count
FROM zz_test_sone_del_meth_src_name
GROUP BY
    id_organisation_source,
    del_meth_src_name
HAVING COUNT(*) > 1
ORDER BY record_count DESC;




SELECT
    appointment_id,
    id_organisation_source,
    rota_type,
    flag_mappings,
    del_meth_src_name
FROM zz_test_sone_del_meth_src_name
WHERE flag_mappings LIKE '%_%'
LIMIT 50;