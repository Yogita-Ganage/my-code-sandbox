WITH base AS (
    SELECT
        sc.ctv3_code,
        CONCAT('SONE', CAST(sc.id_organisation_source AS STRING)) AS src_sys_inst,
        COALESCE(selc.question_heading, dermc.question_heading) AS question_name

    FROM silver_sone_srcode sc

    LEFT JOIN silver_rdm_derm_read_codes dermc
        ON sc.ctv3_code = dermc.code

    LEFT JOIN silver_rdm_sel_read_codes selc
        ON sc.ctv3_code = selc.code

    WHERE sc.id_referral_in IS NOT NULL
)

SELECT
    COUNT(*) AS total_rows,

    SUM(
        CASE WHEN question_name IS NULL
        THEN 1 ELSE 0 END
    ) AS question_name_null,

    SUM(
        CASE WHEN NOT EXISTS (
            SELECT 1
            FROM silver_rdm_form_answer_bridge br
            WHERE TRIM(LOWER(br.form_ans_bridge_src_id))
                = TRIM(LOWER(base.ctv3_code))
        )
        THEN 1 ELSE 0 END
    ) AS code_not_matched,

    SUM(
        CASE WHEN EXISTS (
            SELECT 1
            FROM silver_rdm_form_answer_bridge br
            WHERE TRIM(LOWER(br.form_ans_bridge_src_id))
                = TRIM(LOWER(base.ctv3_code))
        )
        AND NOT EXISTS (
            SELECT 1
            FROM silver_rdm_form_answer_bridge br
            WHERE TRIM(LOWER(br.form_ans_bridge_src_id))
                = TRIM(LOWER(base.ctv3_code))
              AND TRIM(LOWER(br.form_ans_bridge_src_sys_inst_src_id))
                = TRIM(LOWER(base.src_sys_inst))
        )
        THEN 1 ELSE 0 END
    ) AS source_instance_not_matched,

    SUM(
        CASE WHEN EXISTS (
            SELECT 1
            FROM silver_rdm_form_answer_bridge br
            WHERE TRIM(LOWER(br.form_ans_bridge_src_id))
                = TRIM(LOWER(base.ctv3_code))
              AND TRIM(LOWER(br.form_ans_bridge_src_sys_inst_src_id))
                = TRIM(LOWER(base.src_sys_inst))
        )
        AND NOT EXISTS (
            SELECT 1
            FROM silver_rdm_form_answer_bridge br
            WHERE TRIM(LOWER(br.form_ans_bridge_src_id))
                = TRIM(LOWER(base.ctv3_code))
              AND TRIM(LOWER(br.form_ans_bridge_src_sys_inst_src_id))
                = TRIM(LOWER(base.src_sys_inst))
              AND TRIM(LOWER(br.form_ans_bridge_form_ques_src_name))
                = TRIM(LOWER(base.question_name))
        )
        THEN 1 ELSE 0 END
    ) AS question_name_not_matched,

    SUM(
        CASE WHEN EXISTS (
            SELECT 1
            FROM silver_rdm_form_answer_bridge br
            WHERE TRIM(LOWER(br.form_ans_bridge_src_id))
                = TRIM(LOWER(base.ctv3_code))
              AND TRIM(LOWER(br.form_ans_bridge_src_sys_inst_src_id))
                = TRIM(LOWER(base.src_sys_inst))
              AND TRIM(LOWER(br.form_ans_bridge_form_ques_src_name))
                = TRIM(LOWER(base.question_name))
        )
        THEN 1 ELSE 0 END
    ) AS full_bridge_match

FROM base;