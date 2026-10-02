Hi Eve, I investigated the remaining blanks further. The issue seems to be at the join between silver_drj_assessment_result_for_answers and silver_drj_assessment_results.  
assessment_result_for_answers.assessment_result_id is referencing IDs for which there is no matching assessment_results.id record. Because of that, ar.user_id and ar.assessment_id are null, which then causes both form_ans_care_epi_id and form_ans_form_ques_id to be null.  
The current Form Answer logic works correctly where the parent assessment result exists. Could you please check a few of the missing assessment_result_id values in legacy/source to confirm whether those parent records exist there?


SELECT
    arans.assessment_result_id,
    COUNT(*) AS affected_answer_rows
FROM silver_drj_assessment_result_for_answers arans

LEFT JOIN silver_drj_assessment_results ar
    ON arans.assessment_result_id = ar.id

WHERE ar.id IS NULL

GROUP BY arans.assessment_result_id
ORDER BY affected_answer_rows DESC;