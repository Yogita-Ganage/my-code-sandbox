SELECT
    src_session_id,
    session_cprod_id,
    session_cprod_src_id,
    session_cprod_product_conformed,
    session_cprod_service_conformed,
    session_cprod_mstr_service_conformed,
    session_care_epi_id,
    session_patient_id,
    session_date_conformed,
    session_time_conformed,
    session_status_conformed
FROM silver_sessions
WHERE src_session_id = 'WIP505044'
ORDER BY session_cprod_id;



SELECT *
FROM silver_sessions
WHERE src_session_id = 'WIP505044';