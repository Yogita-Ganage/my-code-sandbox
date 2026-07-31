SELECT
    s.session_patient_id,
    s.session_cprod_src_id,
    s.session_cprod_src_sys_inst_id,
    cp.cprod_src_id,
    cp.cprod_src_sys_inst_id,
    cp.cprod_name
FROM silver_session_ytest s
LEFT JOIN <care_product_add_test_table> cp
    ON LOWER(TRIM(s.session_cprod_src_id))
       = LOWER(TRIM(cp.cprod_src_id))
   AND LOWER(TRIM(s.session_cprod_src_sys_inst_id))
       = LOWER(TRIM(cp.cprod_src_sys_inst_id))
WHERE s.session_patient_id = 'SONECOD1260771749';


SELECT
    CASE
        WHEN cp.cprod_src_id IS NULL THEN 'Not Matched'
        WHEN cp.cprod_name IS NULL OR TRIM(cp.cprod_name) = '' THEN 'Matched - Name Blank'
        ELSE 'Matched - Name Available'
    END AS validation_status,
    COUNT(*) AS record_count
FROM silver_session_ytest s
LEFT JOIN <care_product_add_test_table> cp
    ON LOWER(TRIM(s.session_cprod_src_id))
       = LOWER(TRIM(cp.cprod_src_id))
   AND LOWER(TRIM(s.session_cprod_src_sys_inst_id))
       = LOWER(TRIM(cp.cprod_src_sys_inst_id))
WHERE s.session_patient_id = 'SONECOD1260771749'
GROUP BY
    CASE
        WHEN cp.cprod_src_id IS NULL THEN 'Not Matched'
        WHEN cp.cprod_name IS NULL OR TRIM(cp.cprod_name) = '' THEN 'Matched - Name Blank'
        ELSE 'Matched - Name Available'
    END;