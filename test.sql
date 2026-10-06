WITH bridge_stats AS (
    SELECT
        LOWER(TRIM(form_ans_bridge_src_id)) AS src_id,
        LOWER(TRIM(form_ans_bridge_src_sys_inst_src_id)) AS src_inst,
        COUNT(*) AS bridge_rows,
        COUNT(DISTINCT LOWER(TRIM(form_ans_bridge_form_ques_src_name)))
            AS distinct_question_names
    FROM silver_rdm_form_answer_bridging
    WHERE LOWER(TRIM(form_ans_bridge_src_sys_inst_src_id)) LIKE 'sone%'
    GROUP BY
        LOWER(TRIM(form_ans_bridge_src_id)),
        LOWER(TRIM(form_ans_bridge_src_sys_inst_src_id))
),

source_data AS (
    SELECT
        sc.ctv3_code,
        sc.id_organisation_source,
        COALESCE(selc.question_heading, dermc.question_heading)
            AS source_question_heading
    FROM silver_sone_srcode sc

    LEFT JOIN silver_rdm_sel_read_codes selc
        ON LOWER(TRIM(sc.ctv3_code)) = LOWER(TRIM(selc.code))

    LEFT JOIN silver_rdm_derm_read_codes dermc
        ON LOWER(TRIM(sc.ctv3_code)) = LOWER(TRIM(dermc.code))

    WHERE sc.id_referral_in IS NOT NULL
)

SELECT
    SUM(
        CASE
            WHEN source_question_heading IS NULL
             AND bs.distinct_question_names = 1
            THEN 1 ELSE 0
        END
    ) AS safe_unique_fallback_rows,

    SUM(
        CASE
            WHEN source_question_heading IS NULL
             AND bs.distinct_question_names > 1
            THEN 1 ELSE 0
        END
    ) AS ambiguous_rows,

    SUM(
        CASE
            WHEN source_question_heading IS NULL
             AND bs.src_id IS NULL
            THEN 1 ELSE 0
        END
    ) AS no_bridge_mapping_rows

FROM source_data s

LEFT JOIN bridge_stats bs
    ON LOWER(TRIM(s.ctv3_code)) = bs.src_id
   AND LOWER(TRIM(CONCAT('SONE', s.id_organisation_source))) = bs.src_inst;