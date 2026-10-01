SELECT
    COUNT(*) AS unmatched_answer_rows,
    COUNT(DISTINCT arans.assessment_result_id) AS unmatched_distinct_ids
FROM silver_drj_assessment_result_for_answers arans
LEFT JOIN silver_drj_assessment_results ar
    ON arans.assessment_result_id = ar.id
WHERE ar.id IS NULL;