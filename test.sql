,rdmfq.form_ques_id as form_ans_form_ques_id



LEFT JOIN silver_wip_servicetype ty ON ah.service_type_id = ty.id
LEFT JOIN silver_rdm_form_question rdmfq ON TRIM(LOWER(rdmfq.form_ques_src_id)) = TRIM(LOWER(CONCAT('WIP001_', CAST(ty.id AS STRING), '_', CAST(s.group_id AS STRING), '_', CAST(s.type_id AS STRING))))



SELECT
    COUNT(*) AS total_rows,
    COUNT(rdmfq.form_ques_id) AS populated_form_ans_form_ques_id_rows,
    COUNT(*) - COUNT(rdmfq.form_ques_id) AS null_form_ans_form_ques_id_rows
FROM temp_silver_wip_activityheader_statistics s
LEFT JOIN silver_wip_activityheader ah ON ah.id = s.activity_header_id
LEFT JOIN silver_wip_servicetype ty ON ah.service_type_id = ty.id
LEFT JOIN silver_rdm_form_question rdmfq ON TRIM(LOWER(rdmfq.form_ques_src_id)) = TRIM(LOWER(CONCAT('WIP001_', CAST(ty.id AS STRING), '_', CAST(s.group_id AS STRING), '_', CAST(s.type_id AS STRING))));



SELECT
    s.activity_header_id,
    ty.id AS service_type_id,
    s.group_id,
    s.type_id,
    CONCAT('WIP001_', CAST(ty.id AS STRING), '_', CAST(s.group_id AS STRING), '_', CAST(s.type_id AS STRING)) AS expected_form_ques_src_id,
    rdmfq.form_ques_id AS form_ans_form_ques_id,
    rdmfq.form_ques_src_id,
    rdmfq.form_ques_src_name_short,
    s.src_answer_desc AS form_ans_src_answer,
    s.choice_desc AS form_ans_multi_answer_flag
FROM temp_silver_wip_activityheader_statistics s
LEFT JOIN silver_wip_activityheader ah ON ah.id = s.activity_header_id
LEFT JOIN silver_wip_servicetype ty ON ah.service_type_id = ty.id
LEFT JOIN silver_rdm_form_question rdmfq ON TRIM(LOWER(rdmfq.form_ques_src_id)) = TRIM(LOWER(CONCAT('WIP001_', CAST(ty.id AS STRING), '_', CAST(s.group_id AS STRING), '_', CAST(s.type_id AS STRING))))
LIMIT 100;