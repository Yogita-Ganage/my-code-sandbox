
SELECT
    COUNT(*) AS total_rows,
    COUNT(form_ans_form_ques_id) AS populated_form_ans_form_ques_id_rows,
    COUNT(*) - COUNT(form_ans_form_ques_id) AS null_form_ans_form_ques_id_rows
FROM silver_form_answer_test;