SELECT
    src_session_id,
    session_care_epi_id,
    session_patient_id,
    z_src_system_id,
    z_src_system_instance
FROM silver_sessions
WHERE src_session_id IN (
    'SONEG4B9E34376586801',
    'SONEG4B9E34376333367'
);