SELECT
    COUNT(*) AS total_rows,
    COUNT(asmt.id) AS matched_assessment_rows,
    COUNT(*) - COUNT(asmt.id) AS unmatched_assessment_rows
FROM silver_drj_assessment_results ar
LEFT JOIN silver_drj_assessments asmt
    ON asmt.id = ar.assessment_id;