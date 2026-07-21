SELECT
    COUNT(*) AS total_mpb_records,
    SUM(CASE 
            WHEN form_ans_form_ques_id IS NULL THEN 1 
            ELSE 0 
        END) AS null_question_id_count,
    SUM(CASE 
            WHEN form_ans_form_ques_id IS NOT NULL THEN 1 
            ELSE 0 
        END) AS populated_question_id_count
FROM silver_form_answer
WHERE z_src_system_id = 'MPB';