test

SELECT
    ar.id AS assessment_result_id,
    aq.id AS assessment_question_id,
    aq.question,
    COUNT(*) AS answer_row_count,
    COUNT(DISTINCT aa.id) AS distinct_answer_count
FROM silver_drj_assessment_result_for_answers arfa
JOIN silver_drj_assessment_answers aa
    ON arfa.answer_id = aa.id
JOIN silver_drj_assessment_results ar
    ON arfa.assessment_result_id = ar.id
JOIN silver_drj_assessment_questions aq
    ON aa.question_id = aq.id
GROUP BY
    ar.id,
    aq.id,
    aq.question
HAVING COUNT(*) > 1
ORDER BY answer_row_count DESC;