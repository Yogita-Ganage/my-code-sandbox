%%sql

SELECT
    CONCAT('SONE', id_organisation, id) AS current_src_session_id,
    CONCAT('SONE', id_organisation_source, id) AS source_org_src_session_id,

    id,
    id_organisation,
    id_organisation_source,
    appointment_status,
    removed_data,
    id_rota,
    date_start,
    date_end,
    id_profile_clinician,
    id_referral_in

FROM silver_sone_srappointment

WHERE CONCAT('SONE', id_organisation, id)
      = 'SONE00D1Z13047388848'

ORDER BY id_organisation_source, appointment_status;