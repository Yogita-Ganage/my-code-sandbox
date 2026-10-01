SELECT
    form_ans_id,
    COUNT(*) AS null_count
FROM test_silver_form_answer
WHERE form_ans_care_epi_id IS NULL
  AND z_src_system_id = 'MPB'
GROUP BY form_ans_id
ORDER BY null_count DESC;