SELECT
    form_ans_id,
    form_ans_form_ques_id,
    form_ans_care_epi_id,
    form_ans_answer,
    COUNT(*) AS duplicate_count
FROM test_silver_form_answer_filtered_ar
GROUP BY
    form_ans_id,
    form_ans_form_ques_id,
    form_ans_care_epi_id,
    form_ans_answer
HAVING COUNT(*) > 1
ORDER BY duplicate_count DESC;