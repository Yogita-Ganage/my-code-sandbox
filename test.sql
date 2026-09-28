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

WHERE a.id = 158089670415;