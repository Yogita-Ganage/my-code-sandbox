SELECT
    arans.assessment_result_id,
    COUNT(*) AS answer_row_count
FROM silver_drj_assessment_result_for_answers arans
LEFT JOIN silver_drj_assessment_results ar
    ON arans.assessment_result_id = ar.id
WHERE ar.id IS NULL
GROUP BY arans.assessment_result_id
ORDER BY answer_row_count DESC
LIMIT 10;