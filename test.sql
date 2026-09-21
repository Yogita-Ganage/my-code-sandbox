%%sql

SELECT
    COUNT(*) AS total_test_records,
    SUM(
        CASE 
            WHEN form_ques_form_src_name IS NOT NULL
             AND TRIM(form_ques_form_src_name) <> ''
            THEN 1 ELSE 0
        END
    ) AS records_with_form_src_name
FROM test_silver_rdm_form_question_add;



%%sql

SELECT COUNT(*) AS matched_records
FROM test_silver_rdm_form_question_add t
INNER JOIN silver_rdm_form_question r
    ON LOWER(TRIM(t.form_ques_src_id))
       = LOWER(TRIM(r.form_ques_src_id))

   AND LOWER(TRIM(t.form_ques_src_sys_inst_id))
       = LOWER(TRIM(r.form_ques_src_sys_inst_src_id))

   AND LOWER(TRIM(t.form_ques_src_name_full))
       = LOWER(TRIM(r.form_ques_src_name_full));