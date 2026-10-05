SELECT DISTINCT
    sc.ctv3_code,
    sc.ctv3_text,
    sc.id_organisation_source,

    COALESCE(
        selc.question_heading,
        dermc.question_heading
    ) AS source_question_heading,

    br.form_ans_bridge_id,
    br.form_ans_bridge_src_id,
    br.form_ans_bridge_src_sys_inst_src_id,
    br.form_ans_bridge_form_ques_src_name

FROM silver_sone_srcode sc

LEFT JOIN silver_rdm_derm_read_codes dermc
    ON TRIM(LOWER(sc.ctv3_code)) = TRIM(LOWER(dermc.code))

LEFT JOIN silver_rdm_sel_read_codes selc
    ON TRIM(LOWER(sc.ctv3_code)) = TRIM(LOWER(selc.code))

LEFT JOIN silver_rdm_form_answer_bridge br
    ON TRIM(LOWER(sc.ctv3_code))
       = TRIM(LOWER(br.form_ans_bridge_src_id))

   AND TRIM(LOWER(CONCAT('SONE', sc.id_organisation_source)))
       = TRIM(LOWER(br.form_ans_bridge_src_sys_inst_src_id))

WHERE LOWER(TRIM(sc.ctv3_code)) = 'ua0tb'
  AND LOWER(TRIM(sc.id_organisation_source)) = 'o0d1z';