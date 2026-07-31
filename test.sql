SELECT
    s.session_patient_id,
    s.session_cprod_src_id,
    br.cprod_src_id AS bridge_cprod_src_id
FROM silver_session_ytest s
LEFT JOIN silver_sone_srrotaslot_bridging_to_srappointment br
    ON CONCAT('SONE', s.session_src_sys_inst_id, s.session_src_id) = br.src_session_id
WHERE s.session_patient_id = 'SONECOD1260771749';