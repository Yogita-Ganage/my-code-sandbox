SELECT DISTINCT
    sra.id AS appointment_id,
    sra.id_referral_in AS referral_id,

    bridgetoapp.rota_slot_type,
    bridgetoapp.rota_type,
    bridgetoapp.id_organisation_source,

    clo.id AS configured_list_option_id,
    clo.configured_list_option

FROM silver_sone_srappointment sra

LEFT JOIN silver_sone_srrotaslot_bridging_to_srappointment bridgetoapp
    ON CONCAT('SONE', sra.id_organisation, sra.id) = bridgetoapp.src_session_id
    AND sra.id_organisation = bridgetoapp.id_organisation_source

LEFT JOIN silver_sone_srconfiguredlistoption clo
    ON clo.id_organisation_source = bridgetoapp.id_organisation_source
    AND LOWER(TRIM(clo.configured_list_option))
        = LOWER(TRIM(bridgetoapp.rota_slot_type))

WHERE sra.id IN (34566831071, 34466326203);