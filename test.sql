SELECT
    COUNT(*) AS total_rows,

    SUM(
        CASE WHEN ar.id IS NULL
        THEN 1 ELSE 0 END
    ) AS assessment_result_not_matched,

    SUM(
        CASE WHEN ar.id IS NOT NULL
              AND ar.user_id IS NULL
        THEN 1 ELSE 0 END
    ) AS matched_but_user_id_null,

    SUM(
        CASE WHEN ar.user_id IS NOT NULL
        THEN 1 ELSE 0 END
    ) AS user_id_present

FROM silver_drj_assessment_result_for_answers arans

LEFT JOIN silver_drj_assessment_results ar
    ON arans.assessment_result_id = ar.id;