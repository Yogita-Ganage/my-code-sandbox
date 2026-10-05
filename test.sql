88,152 blanks are caused by NULL id_referral_in values already present in silver_sone_srcode; the Form Answer mapping itself is working as defined.


SELECT
    COUNT(*) AS total_rows,

    SUM(
        CASE WHEN br.form_ans_bridge_id IS NULL
        THEN 1 ELSE 0 END
    ) AS bridge_not_matched,

    SUM(
        CASE
            WHEN br.form_ans_bridge_id IS NOT NULL
             AND rdmfq.form_ques_id IS NULL
            THEN 1 ELSE 0
        END
    ) AS bridge_matched_but_form_question_not_matched,

    SUM(
        CASE WHEN rdmfq.form_ques_id IS NOT NULL
        THEN 1 ELSE 0 END
    ) AS form_question_matched

FROM silver_sone_srcode sc

LEFT JOIN silver_rdm_derm_read_codes dermc
    ON sc.ctv3_code = dermc.code

LEFT JOIN silver_rdm_sel_read_codes selc
    ON sc.ctv3_code = selc.code

LEFT JOIN silver_rdm_form_answer_bridge br
    ON TRIM(LOWER(sc.ctv3_code))
       = TRIM(LOWER(br.form_ans_bridge_src_id))

   AND TRIM(LOWER(CONCAT('SONE', sc.id_organisation_source)))
       = TRIM(LOWER(br.form_ans_bridge_src_sys_inst_src_id))

   AND TRIM(LOWER(COALESCE(selc.question_heading, dermc.question_heading)))
       = TRIM(LOWER(br.form_ans_bridge_form_ques_src_name))

LEFT JOIN silver_rdm_form_question rdmfq
    ON TRIM(LOWER(rdmfq.form_ques_src_id))
       = TRIM(LOWER(CONCAT(
           CAST(br.form_ans_bridge_src_sys_inst_src_id AS STRING),
           '_',
           CAST(br.form_ans_bridge_id AS STRING)
       )));