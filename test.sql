SELECT DISTINCT
    src_session_id,
    id_organisation_source,
    rota_slot_type,
    rota_type
FROM silver_sone_srrotaslot_bridging_to_srappointment
WHERE src_session_id LIKE '%34566831071%'
   OR src_session_id LIKE '%34466326203%';



SELECT DISTINCT
    src_session_id,
    id_organisation_source,
    rota_slot_type,
    rota_type
FROM silver_sone_srrotaslot_bridging_to_srappointment
WHERE id_organisation_source = '00D1Z'
  AND (
        LOWER(rota_slot_type) LIKE '%initial consultation%'
        OR LOWER(rota_type) LIKE '%bromley physio%'
      );