SELECT
    COUNT(*) AS total_rows,
    COUNT(rdmfq.form_ques_id) AS matched_rdm_form_question_rows,
    COUNT(*) - COUNT(rdmfq.form_ques_id) AS unmatched_rdm_form_question_rows
FROM temp_silver_wip_activityheader_statistics s

LEFT JOIN silver_wip_activityheader ah
    ON ah.id = s.activity_header_id

LEFT JOIN silver_wip_servicetype ty
    ON ah.service_type_id = ty.id

LEFT JOIN silver_rdm_form_question rdmfq
    ON TRIM(LOWER(rdmfq.form_ques_src_id)) =
       TRIM(LOWER(CONCAT(
           'WIP001_',
           CAST(ty.id AS STRING),
           '_',
           CAST(s.group_id AS STRING),
           '_',
           CAST(s.type_id AS STRING)
       )));





