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

    LEFT JOIN silver_rdm_form_answer_bridging br
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
    HAVING COUNT(*) > 1
)
SELECT
    b.ques_id,
    b.session_id,
    c.answer_count,
    b.answer_value
FROM s1_base b
JOIN answer_counts c
    ON b.ques_id = c.ques_id
    AND b.session_id = c.session_id
ORDER BY
    c.answer_count DESC,
    b.ques_id,
    b.session_id
LIMIT 50;