SELECT
    care_epi_number,
    care_epi_patient_id,
    care_epi_referral_date,
    care_epi_closure_date,
    CASE
        WHEN care_epi_patient_id = 'SONEG4B9E66173613'
            THEN 'Correct'
        ELSE 'Check'
    END AS validation_result
FROM silver_care_episode
WHERE z_src_system_id = 'SONE'
  AND care_epi_number IN ('76046740', '76050032')
ORDER BY care_epi_number;