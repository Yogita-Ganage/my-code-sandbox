SELECT
    CONCAT('SONE', sra.id_organisation, sra.id) AS src_session_id,

    CONCAT('SONE', sra.id_organisation, sra.id_referral_in) AS session_care_epi_id_from_appointment,

    CONCAT('SONE', srri.id_organisation_source, srri.id) AS care_epi_id_from_referral,

    sra.id_patient AS appointment_id_patient,

    srri.id_patient AS referral_id_patient,

    CONCAT('SONE', sra.id_organisation, sra.id_patient) AS current_session_patient_id_from_appointment,

    CONCAT('SONE', srri.id_organisation_source, srri.id_patient) AS patient_id_from_referral

FROM silver_sone_srappointment sra

LEFT JOIN silver_sone_srreferralin srri
    ON sra.id_referral_in = srri.id
   AND sra.id_organisation = srri.id_organisation_source

WHERE CONCAT('SONE', sra.id_organisation, sra.id) IN (
    'इथे पहिला src_session_id टाक',
    'इथे दुसरा src_session_id टाक'
);