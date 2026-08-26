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