%%sql

DROP TABLE IF EXISTS zz_test_sone_delivery_method;

CREATE TABLE zz_test_sone_delivery_method AS

WITH sone_appointment_flags AS
(
    SELECT
        af.id_appointment,
        af.id_organisation_source,

        -- Combine all mapped flag descriptions in alphabetical order
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

    WHERE m.mapping IS NOT NULL

    GROUP BY
        af.id_appointment,
        af.id_organisation_source
),

appointment_delivery_method AS
(
    SELECT
        a.id AS appointment_id,
        a.id_organisation_source,

        CONCAT(
            'SONE',
            a.id_organisation_source
        ) AS del_meth_src_sys_inst_id,

        -- New Source Name definition:
        -- rota_type + all appointment flag mapping descriptions
        CONCAT_WS(
            '_',
            TRIM(a.rota_type),
            f.flag_mappings
        ) AS del_meth_src_name

    FROM silver_sone_srappointment a

    LEFT JOIN sone_appointment_flags f
        ON a.id = f.id_appointment
        AND a.id_organisation_source = f.id_organisation_source

    WHERE a.rota_type IS NOT NULL
)

SELECT DISTINCT

    -- No unique source ID is available in SONE,
    -- so derive ID from system instance + the same values used for Source Name
    CONCAT(
        'SONE',
        id_organisation_source,
        '_',
        LOWER(TRIM(del_meth_src_name))
    ) AS del_meth_src_id,

    del_meth_src_sys_inst_id,

    del_meth_src_name

FROM appointment_delivery_method

WHERE del_meth_src_name IS NOT NULL
  AND TRIM(del_meth_src_name) <> '';




SELECT *
FROM zz_test_sone_delivery_method
LIMIT 50;

SELECT
    COUNT(*) AS total_rows,
    COUNT(DISTINCT del_meth_src_id) AS distinct_ids
FROM zz_test_sone_delivery_method;