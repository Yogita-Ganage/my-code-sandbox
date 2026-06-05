,rdmfq.form_ques_id as form_ans_form_ques_id



LEFT JOIN silver_wip_servicetype ty ON ah.service_type_id = ty.id
LEFT JOIN silver_rdm_form_question rdmfq ON TRIM(LOWER(rdmfq.form_ques_src_id)) = TRIM(LOWER(CONCAT('WIP001_', CAST(ty.id AS STRING), '_', CAST(s.group_id AS STRING), '_', CAST(s.type_id AS STRING))))