SELECT
    COUNT(*) AS total_srcode_rows,
    COUNT(br.form_ans_bridge_id) AS matched_bridging_rows,
    COUNT(rdmfq.form_ques_id) AS matched_rdm_form_question_rows,
    COUNT(br.form_ans_bridge_id) - COUNT(rdmfq.form_ques_id) AS bridging_matched_but_no_form_question_rows,
    COUNT(*) - COUNT(br.form_ans_bridge_id) AS not_matched_to_bridging_rows
FROM silver_sone_srcode sc

LEFT JOIN silver_rdm_derm_read_codes dermc
    ON sc.ctv3_code = dermc.code

LEFT JOIN silver_rdm_sel_read_codes selc
    ON sc.ctv3_code = selc.code

LEFT JOIN silver_rdm_form_answer_bridging br
    ON TRIM(LOWER(sc.ctv3_code)) = TRIM(LOWER(br.form_ans_bridge_src_id))
   AND TRIM(LOWER(CONCAT('SONE', sc.id_organisation_source))) = TRIM(LOWER(br.form_ans_bridge_src_sys_inst_src_id))
   AND TRIM(LOWER(COALESCE(selc.question_heading, dermc.question_heading))) = TRIM(LOWER(br.form_ans_bridge_form_ques_src_name))

LEFT JOIN silver_rdm_form_question rdmfq
    ON TRIM(LOWER(rdmfq.form_ques_src_id)) =
       TRIM(LOWER(CONCAT(CAST(br.form_ans_bridge_src_sys_inst_src_id AS STRING), '_', CAST(br.form_ans_bridge_id AS STRING))));