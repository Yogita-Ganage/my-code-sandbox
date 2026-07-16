%%sql

SELECT
    activity_header_id,
    group_id,
    group_desc,
    raw_session_date,
    clean_session_date,
    parsed_form_ans_date
FROM temp_wip_form_answer_parsed_date_lookup
WHERE raw_session_date IN (
    '29/08/1014',
    '03/03/1016',
    '17 December 1019',
    '09/09/1021',
    '1/12/1021',
    '11/1/1023',
    '21.2.1024'
)
ORDER BY raw_session_date;