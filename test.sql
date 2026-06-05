,rdmfq.form_ques_id as form_ans_form_ques_id




LEFT JOIN
    silver_drj_assessments asmt on asmt.id = ar.assessment_id

LEFT JOIN
    silver_rdm_form_question rdmfq
        on TRIM(LOWER(rdmfq.form_ques_src_id)) =
           TRIM(LOWER(CONCAT('MPB001_', CAST(asmt.id AS STRING))))