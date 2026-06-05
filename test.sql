SELECT
    ar.id AS assessment_result_id,
    ar.assessment_id,
    asmt.id AS assessment_table_id,

    CONCAT('MPB001_', CAST(asmt.id AS STRING)) AS expected_form_ques_src_id,

    rdmfq.form_ques_id AS expected_form_ans_form_ques_id,
    rdmfq.form_ques_src_id,
    rdmfq.form_ques_src_sys_inst_id,
    rdmfq.form_ques_src_name_short,

    asmq.id AS old_assessment_question_id,
    CONCAT('MPB', asmq.id) AS old_form_ans_form_ques_id,

    ar.score AS form_ans_src_answer,
    ar.created_at AS form_ans_date_time

FROM silver_drj_assessment_result_for_answers arans

LEFT JOIN silver_drj_assessment_answers asmans
    ON asmans.id = arans.assessment_answer_id

LEFT JOIN silver_drj_assessment_results ar
    ON arans.assessment_result_id = ar.id

LEFT JOIN silver_drj_assessments asmt
    ON asmt.id = ar.assessment_id

LEFT JOIN silver_drj_assessment_questions asmq
    ON asmq.id = asmans.assessment_question_id

LEFT JOIN silver_rdm_form_question rdmfq
    ON TRIM(LOWER(rdmfq.form_ques_src_id)) = TRIM(LOWER(CONCAT('MPB001_', CAST(asmt.id AS STRING))))
   AND TRIM(LOWER(rdmfq.form_ques_src_sys_inst_id)) = 'mpb001'

LIMIT 100;






SELECT
    COUNT(*) AS total_rows,
    COUNT(rdmfq.form_ques_id) AS matched_rdm_form_question_rows,
    COUNT(*) - COUNT(rdmfq.form_ques_id) AS unmatched_rdm_form_question_rows
FROM silver_drj_assessment_result_for_answers arans

LEFT JOIN silver_drj_assessment_answers asmans
    ON asmans.id = arans.assessment_answer_id

LEFT JOIN silver_drj_assessment_results ar
    ON arans.assessment_result_id = ar.id

LEFT JOIN silver_drj_assessments asmt
    ON asmt.id = ar.assessment_id

LEFT JOIN silver_rdm_form_question rdmfq
    ON TRIM(LOWER(rdmfq.form_ques_src_id)) = TRIM(LOWER(CONCAT('MPB001_', CAST(asmt.id AS STRING))))
   AND TRIM(LOWER(rdmfq.form_ques_src_sys_inst_id)) = 'mpb001';