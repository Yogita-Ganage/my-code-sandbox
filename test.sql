SELECT
    COUNT(*) AS total_with_ar,
    SUM(CASE WHEN rdmfq.form_ques_id IS NULL THEN 1 ELSE 0 END) AS form_ques_mapping_failed,
    SUM(CASE WHEN rdmfq.form_ques_id IS NOT NULL THEN 1 ELSE 0 END) AS form_ques_mapping_success
FROM silver_drj_assessment_result_for_answers arans

LEFT JOIN silver_drj_assessment_answers asmans
    ON asmans.id = arans.assessment_answer_id

LEFT JOIN silver_drj_assessment_results ar
    ON arans.assessment_result_id = ar.id

LEFT JOIN silver_drj_assessments asmt
    ON asmt.id = ar.assessment_id

LEFT JOIN silver_rdm_form_question rdmfq
    ON TRIM(LOWER(rdmfq.form_ques_src_id))
     = TRIM(LOWER(CONCAT('MPB001_', CAST(asmt.id AS STRING))))

WHERE ar.id IS NOT NULL;