WITH s1_base AS (
    SELECT
        rdmfq.form_ques_id AS ques_id,
        CONCAT('SONE', sc.id_appointment) AS session_id,
        CONCAT(sc.ctv3_code, br.form_ans_bridge_form_ans_conformed_answer) AS answer_value
    FROM silver_sone_srcode sc
    LEFT JOIN silver_rdm_derm_read_codes dermc
        ON sc.ctv3_code = dermc.code
    LEFT JOIN silver_rdm_sel_read_codes selc
        ON sc.ctv3_code = selc.code
    LEFT JOIN silver_form_ans_bridge br
        ON TRIM(LOWER(sc.ctv3_code)) = TRIM(LOWER(br.form_ans_bridge_src_id))
        AND TRIM(LOWER(CONCAT('SONE', sc.id_organisation_source))) =
            TRIM(LOWER(br.form_ans_bridge_src_sys_inst_src_id))
        AND TRIM(LOWER(COALESCE(selc.question_heading, dermc.question_heading))) =
            TRIM(LOWER(br.form_ans_bridge_form_ques_src_name))
    LEFT JOIN silver_rdm_form_question rdmfq
        ON TRIM(LOWER(rdmfq.form_ques_src_id)) =
            TRIM(LOWER(CONCAT(
                CAST(br.form_ans_bridge_src_sys_inst_src_id AS STRING),
                '_',
                CAST(br.form_ans_bridge_id AS STRING)
            )))
),
answer_counts AS (
    SELECT
        ques_id,
        session_id,
        COUNT(*) AS answer_count
    FROM s1_base
    GROUP BY
        ques_id,
        session_id
)
SELECT
    CASE
        WHEN answer_count > 1 THEN 'Multi answer'
        ELSE 'Single answer'
    END AS answer_pattern,
    COUNT(*) AS record_count
FROM answer_counts
GROUP BY
    CASE
        WHEN answer_count > 1 THEN 'Multi answer'
        ELSE 'Single answer'
    END;