,rdmfq.form_ques_id as form_ans_form_ques_id


LEFT JOIN silver_rdm_form_question rdmfq ON TRIM(LOWER(rdmfq.form_ques_src_id)) = TRIM(LOWER(CONCAT(CAST(br.form_ans_bridge_src_sys_inst_src_id AS STRING), '_', CAST(br.form_ans_bridge_id AS STRING))))