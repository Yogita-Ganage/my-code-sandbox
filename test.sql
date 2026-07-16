%%sql

SELECT
    form_ans_id,
    form_ans_care_epi_id,
    form_ans_form_ques_id,
    form_ans_date,
    form_ans_date_time,
    z_src_system_id,
    z_src_system_instance
FROM silver_form_answer
WHERE z_src_system_id = 'MPB'
  AND (
        form_ans_date < DATE '1899-12-30'
        OR form_ans_date > DATE '9999-12-31'
      )
ORDER BY form_ans_date
LIMIT 100;