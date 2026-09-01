SELECT DISTINCT
    srref.id AS referral_id,
    sra.id AS appointment_id,

    -- Source values used to derive Delivery Method
    bridgetoapp.rota_slot_type,
    bridgetoapp.rota_type,

    -- Delivery Method Source ID
    CONCAT(
        'SONE',
        bridgetoapp.id_organisation_source,
        '_',
        LOWER(
            CONCAT(
                TRIM(bridgetoapp.rota_slot_type),
                ' - ',
                TRIM(bridgetoapp.rota_type)
            )
        )
    ) AS del_meth_src_id,

    -- Delivery Method Source System Instance ID
    CONCAT(
        'SONE',
        bridgetoapp.id_organisation_source
    ) AS del_meth_src_sys_inst_id,

    -- Delivery Method Source Name
    CONCAT(
        TRIM(bridgetoapp.rota_slot_type),
        ' - ',
        TRIM(bridgetoapp.rota_type)
    ) AS del_meth_src_name

FROM silver_sone_srappointment sra

LEFT JOIN silver_sone_srreferralin srref
    ON srref.id = sra.id_referral_in

LEFT JOIN silver_sone_srrotaslot_bridging_to_srappointment bridgetoapp
    ON CONCAT('SONE', sra.id_organisation, sra.id) = bridgetoapp.src_session_id
    AND sra.id_organisation = bridgetoapp.id_organisation_source

WHERE srref.id = 75902966;