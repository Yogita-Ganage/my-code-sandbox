SELECT 'bronze_drj_assessmentresults' AS table_name,
       COUNT(*) AS row_count
FROM bronze_drj_assessmentresults

UNION ALL

SELECT 'silver_drj_assessment_results',
       COUNT(*)
FROM silver_drj_assessment_results

UNION ALL

SELECT 'bronze_drj_assessmentresultforanswers',
       COUNT(*)
FROM bronze_drj_assessmentresultforanswers

UNION ALL

SELECT 'silver_drj_assessment_result_for_answers',
       COUNT(*)
FROM silver_drj_assessment_result_for_answers

UNION ALL

SELECT 'bronze_drj_assessmentanswers',
       COUNT(*)
FROM bronze_drj_assessmentanswers

UNION ALL

SELECT 'silver_drj_assessment_answers',
       COUNT(*)
FROM silver_drj_assessment_answers;


SELECT *
FROM bronze_drj_assessmentresults
WHERE id = 477787;