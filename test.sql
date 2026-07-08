SELECT
    COUNT(*) AS total_rows,
    SUM(CASE WHEN fab.form_ans_bridge_form_ques_src_tab IS NULL THEN 1 ELSE 0 END) AS null_tab_rows,
    SUM(CASE WHEN TRIM(fab.form_ans_bridge_form_ques_src_tab) = '' THEN 1 ELSE 0 END) AS blank_tab_rows,
    SUM(CASE WHEN fab.form_ans_bridge_form_ques_src_name IS NULL THEN 1 ELSE 0 END) AS null_question_rows
FROM silver_rdm_form_answer_bridging fab
WHERE fab.form_ans_bridge_id IS NOT NULL
  AND fab.form_ans_bridge_src_sys_inst_src_id IS NOT NULL
  AND fab.form_ans_bridge_form_ques_src_name IS NOT NULL;



  SELECT
    fab.form_ans_bridge_id,
    fab.form_ans_bridge_src_sys_inst_src_id,
    fab.form_ans_bridge_form_ques_src_tab,
    fab.form_ans_bridge_form_ques_src_name
FROM silver_rdm_form_answer_bridging fab
WHERE fab.form_ans_bridge_id IS NOT NULL
  AND fab.form_ans_bridge_src_sys_inst_src_id IS NOT NULL
  AND fab.form_ans_bridge_form_ques_src_name IS NOT NULL
  AND (
      fab.form_ans_bridge_form_ques_src_tab IS NULL
      OR TRIM(fab.form_ans_bridge_form_ques_src_tab) = ''
  )
LIMIT 50;