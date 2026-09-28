SELECT
    src_session_id,
    cprod_src_id,
    rota_type,
    rota_slot_type,
    id_organisation_source
FROM silver_sone_srrotaslot_bridging_to_srappointment
WHERE cprod_src_id IS NOT NULL
LIMIT 50;