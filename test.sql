sone_source AS (

    SELECT DISTINCT
        CONCAT('SONE', sra.id_organisation_source, '_', cfg3.id) AS del_meth_src_id,
        CONCAT('SONE', sra.id_organisation_source) AS del_meth_src_sys_inst_id,
        cfg3.configured_list_option AS del_meth_src_name

    FROM silver_sone_srappointment sra

    LEFT JOIN (
        SELECT
            id_appointment,
            id_event,
            date_event,
            ROW_NUMBER() OVER (
                PARTITION BY id_appointment
                ORDER BY date_event DESC
            ) AS rowno
        FROM silver_sone_sreventlink
    ) srevl
        ON srevl.id_appointment = sra.id
        AND srevl.rowno = 1

    LEFT JOIN silver_sone_srevent srev
        ON srev.id = srevl.id_event

    LEFT JOIN silver_sone_srconfiguredlistoption cfg3
        ON cfg3.id = srev.contact_method

    WHERE cfg3.id IS NOT NULL
)








sone_source AS (

    SELECT DISTINCT
        CONCAT('SONE', sra.id_organisation_source, '_', cfg3.id) AS del_meth_src_id,
        CONCAT('SONE', sra.id_organisation_source) AS del_meth_src_sys_inst_id,
        cfg3.configured_list_option AS del_meth_src_name

    FROM silver_sone_srappointment sra

    LEFT JOIN silver_sone_srevent srev
        ON srev.id_appointment = sra.id
        AND srev.id_organisation = sra.id_organisation_source

    LEFT JOIN silver_sone_srconfiguredlistoption cfg3
        ON cfg3.id = srev.contact_method

    WHERE cfg3.id IS NOT NULL
)