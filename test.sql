SELECT
    asmq.type,
    asmq.maximum_selection,
    COUNT(*) AS record_count
FROM silver_drj_assessment_result_for_answers arans
LEFT JOIN silver_drj_assessment_answers asmans
    ON asmans.id = arans.assessment_answer_id
LEFT JOIN silver_drj_assessment_questions asmq
    ON asmq.id = asmans.assessment_question_id
GROUP BY
    asmq.type,
    asmq.maximum_selection
ORDER BY
    asmq.type,
    asmq.maximum_selection;




SELECT
    CASE
        WHEN COALESCE(asmq.maximum_selection, 1) > 1 THEN 'Multi selection allowed'
        ELSE 'Single selection/score'
    END AS multi_answer_check,
    COUNT(*) AS record_count
FROM silver_drj_assessment_result_for_answers arans
LEFT JOIN silver_drj_assessment_answers asmans
    ON asmans.id = arans.assessment_answer_id
LEFT JOIN silver_drj_assessment_questions asmq
    ON asmq.id = asmans.assessment_question_id
GROUP BY
    CASE
        WHEN COALESCE(asmq.maximum_selection, 1) > 1 THEN 'Multi selection allowed'
        ELSE 'Single selection/score'
    END;