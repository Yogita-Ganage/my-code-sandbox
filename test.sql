%%sql

DROP TABLE IF EXISTS test_wip_form_answer_form_ques_id;

CREATE TABLE test_wip_form_answer_form_ques_id AS
SELECT
    999 AS form_ans_id,
    rdmfq.form_ques_id AS form_ans_form_ques_id,
    CONCAT('WIP001', ah.file_number) AS form_ans_care_epi_id,
    s.src_answer_desc AS form_ans_src_answer,
    s.choice_desc AS form_ans_multi_answer_flag,
    'WIP001' AS z_src_system_instance,
    'WIP' AS z_src_system_id
FROM temp_silver_wip_activityheader_statistics s
LEFT JOIN silver_wip_activityheader ah ON ah.id = s.activity_header_id
LEFT JOIN silver_wip_servicetype ty ON ah.service_type_id = ty.id
LEFT JOIN silver_rdm_form_question rdmfq ON TRIM(LOWER(rdmfq.form_ques_src_id)) = TRIM(LOWER(CONCAT('WIP001_', CAST(ty.id AS STRING), '_', CAST(s.group_id AS STRING), '_', CAST(s.type_id AS STRING))));



%%sql

SELECT
    COUNT(*) AS total_rows,
    COUNT(form_ans_form_ques_id) AS populated_form_ans_form_ques_id_rows,
    COUNT(*) - COUNT(form_ans_form_ques_id) AS null_form_ans_form_ques_id_rows
FROM test_wip_form_answer_form_ques_id;


%%sql

SELECT
    form_ans_id,
    form_ans_form_ques_id,
    form_ans_care_epi_id,
    form_ans_src_answer,
    form_ans_multi_answer_flag,
    z_src_system_instance,
    z_src_system_id
FROM test_wip_form_answer_form_ques_id
LIMIT 100;


%%sql

DROP TABLE IF EXISTS test_wip_form_answer_form_ques_id;