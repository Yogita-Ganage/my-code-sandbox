SELECT
    form_ans_bridge_src_id,
    form_ans_bridge_src_sys_inst_src_id,
    COUNT(*) AS bridge_rows,
    COUNT(DISTINCT form_ans_bridge_form_ques_src_name) AS distinct_question_names
FROM silver_rdm_form_answer_bridging
WHERE LOWER(TRIM(form_ans_bridge_src_id)) = 'ua0tb'
  AND LOWER(TRIM(form_ans_bridge_src_sys_inst_src_id)) = 'soneo0d1z'
GROUP BY
    form_ans_bridge_src_id,
    form_ans_bridge_src_sys_inst_src_id;