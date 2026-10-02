SELECT COUNT(*) 
FROM test_silver_form_answer_filtered_ar;

SELECT
    (SELECT COUNT(*) FROM test_silver_form_answer_new) AS old_count,
    (SELECT COUNT(*) FROM test_silver_form_answer_filtered) AS new_count,
    (SELECT COUNT(*) FROM test_silver_form_answer_new)
      -
    (SELECT COUNT(*) FROM test_silver_form_answer_filtered) AS difference;


SELECT
    SUM(CASE WHEN form_ans_care_epi_id IS NULL THEN 1 ELSE 0 END)
        AS care_epi_nulls,

    SUM(CASE WHEN form_ans_form_ques_id IS NULL THEN 1 ELSE 0 END)
        AS form_ques_nulls,

    COUNT(*) AS total_rows
FROM test_silver_form_answer_filtered;