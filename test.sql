%%sql

SELECT
    form_ques_src_id,
    form_ques_src_sys_inst_src_id,
    form_ques_src_name_full,
    COUNT(*) AS cnt
FROM silver_rdm_form_question
GROUP BY
    form_ques_src_id,
    form_ques_src_sys_inst_src_id,
    form_ques_src_name_full
HAVING COUNT(*) > 1;


%%sql

SELECT COUNT(*) AS records_requiring_backfill
FROM test_silver_rdm_form_question_add t
INNER JOIN silver_rdm_form_question r
    ON LOWER(TRIM(t.form_ques_src_id))
       = LOWER(TRIM(r.form_ques_src_id))

   AND LOWER(TRIM(t.form_ques_src_sys_inst_id))
       = LOWER(TRIM(r.form_ques_src_sys_inst_src_id))

   AND LOWER(TRIM(t.form_ques_src_name_full))
       = LOWER(TRIM(r.form_ques_src_name_full))

WHERE t.form_ques_form_src_name IS NOT NULL
  AND TRIM(t.form_ques_form_src_name) <> ''

  AND (
        r.form_ques_form_src_name IS NULL
        OR TRIM(r.form_ques_form_src_name) = ''
      );


%%sql

SELECT
    t.form_ques_src_sys_inst_id,
    COUNT(*) AS records_requiring_backfill
FROM test_silver_rdm_form_question_add t
INNER JOIN silver_rdm_form_question r
    ON LOWER(TRIM(t.form_ques_src_id))
       = LOWER(TRIM(r.form_ques_src_id))

   AND LOWER(TRIM(t.form_ques_src_sys_inst_id))
       = LOWER(TRIM(r.form_ques_src_sys_inst_src_id))

   AND LOWER(TRIM(t.form_ques_src_name_full))
       = LOWER(TRIM(r.form_ques_src_name_full))

WHERE t.form_ques_form_src_name IS NOT NULL
  AND TRIM(t.form_ques_form_src_name) <> ''

  AND (
        r.form_ques_form_src_name IS NULL
        OR TRIM(r.form_ques_form_src_name) = ''
      )

GROUP BY t.form_ques_src_sys_inst_id
ORDER BY records_requiring_backfill DESC;




%%sql

SELECT
    t.form_ques_src_id,
    t.form_ques_src_sys_inst_id,
    t.form_ques_src_name_full,
    t.form_ques_form_src_name AS new_form_src_name,
    r.form_ques_form_src_name AS existing_form_src_name
FROM test_silver_rdm_form_question_add t
INNER JOIN silver_rdm_form_question r
    ON LOWER(TRIM(t.form_ques_src_id))
       = LOWER(TRIM(r.form_ques_src_id))

   AND LOWER(TRIM(t.form_ques_src_sys_inst_id))
       = LOWER(TRIM(r.form_ques_src_sys_inst_src_id))

   AND LOWER(TRIM(t.form_ques_src_name_full))
       = LOWER(TRIM(r.form_ques_src_name_full))

WHERE t.form_ques_form_src_name IS NOT NULL
  AND TRIM(t.form_ques_form_src_name) <> ''

  AND (
        r.form_ques_form_src_name IS NULL
        OR TRIM(r.form_ques_form_src_name) = ''
      );