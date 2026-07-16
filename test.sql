%%sql

SELECT
    activity_header_id,
    group_id,
    group_desc,
    raw_session_date,
    clean_session_date,
    parsed_form_ans_date
FROM temp_wip_form_answer_parsed_date_lookup
WHERE parsed_form_ans_date < DATE '1899-12-30'
   OR parsed_form_ans_date > DATE '9999-12-31'
ORDER BY parsed_form_ans_date;