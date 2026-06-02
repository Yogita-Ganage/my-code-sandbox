LEFT JOIN temp_wip_form_answer_parsed_date_lookup pdl
    ON pdl.activity_header_id = s.activity_header_id
   AND pdl.group_id = s.group_id
   AND TRIM(LOWER(pdl.group_desc)) = TRIM(LOWER(s.group_desc))


,pdl.parsed_form_ans_date AS form_ans_date




%%sql

SELECT
    COUNT(*) AS total_rows,
    COUNT(form_ans_date) AS populated_form_ans_date_rows,
    COUNT(*) - COUNT(form_ans_date) AS null_form_ans_date_rows
FROM wiptest_silver_form_answer
WHERE z_src_system_id = 'WIP';


%%sql

SELECT
    form_ans_form_ques_id,
    form_ans_care_epi_id,
    form_ans_src_answer,
    form_ans_date,
    z_src_system_instance,
    z_src_system_id
FROM wiptest_silver_form_answer
WHERE z_src_system_id = 'WIP'
  AND form_ans_date IS NOT NULL
LIMIT 50;


%%sql

SELECT
    form_ans_form_ques_id,
    form_ans_care_epi_id,
    form_ans_src_answer,
    form_ans_date,
    COUNT(*) AS row_count
FROM wiptest_silver_form_answer
WHERE z_src_system_id = 'WIP'
GROUP BY
    form_ans_form_ques_id,
    form_ans_care_epi_id,
    form_ans_src_answer,
    form_ans_date
HAVING COUNT(*) > 1
ORDER BY row_count DESC
LIMIT 50;