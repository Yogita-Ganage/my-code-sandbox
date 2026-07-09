SELECT
    CONCAT('SONE', sra.id_organisation, sra.id) AS src_session_id,
    CONCAT('SONE', sra.id_organisation, sra.id_referral_in) AS session_care_epi_id,
    sra.id_patient,
    CONCAT('SONE', sra.id_organisation, sra.id_patient) AS session_patient_id_from_appointment,
    sra.*
FROM silver_sone_srappointment sra
WHERE CONCAT('SONE', sra.id_organisation, sra.id) IN (
    'SONEG4B9E343765868001',
    'SONEG4B9E343763333367'
);



SELECT
    CONCAT('SONE', id_organisation_source, id) AS care_epi_id,
    id_patient,
    CONCAT('SONE', id_organisation_source, id_patient) AS patient_id_from_referral,
    *
FROM silver_sone_srreferralin
WHERE CONCAT('SONE', id_organisation_source, id) IN (
    'SONEG4B9E76059032',
    'SONEG4B9E76045740'
);