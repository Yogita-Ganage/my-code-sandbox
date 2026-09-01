SELECT
    sra.id AS appointment_id,
    sra.id_referral_in,
    sra.id_organisation,
    sra.id_rota,
    sra.rota_name,
    sra.rota_type,
    bridgetoapp.*
FROM silver_sone_srappointment sra

LEFT JOIN silver_sone_srrotaslot_bridging_to_srappointment bridgetoapp
    ON CONCAT('SONE', sra.id_organisation, sra.id)
       = bridgetoapp.src_session_id
    AND sra.id_organisation
       = bridgetoapp.id_organisation_source

WHERE sra.id IN (34566831071, 34466326203);