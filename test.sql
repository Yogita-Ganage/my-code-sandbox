%%sql

SELECT
    activity_header_id,
    group_id,
    group_desc,
    type_id,
    type_desc,
    value_desc
FROM test_temp_silver_wip_activityheader_statistics
WHERE TRIM(LOWER(type_desc)) IN ('call date', 'session date')
  AND value_desc IS NOT NULL
  AND (
        value_desc RLIKE '21[0-9]{2}'
     OR value_desc RLIKE '22[0-9]{2}'
     OR value_desc RLIKE '23[0-9]{2}'
     OR value_desc RLIKE '24[0-9]{2}'
     OR value_desc RLIKE '25[0-9]{2}'
     OR value_desc RLIKE '29[0-9]{2}'
     OR value_desc RLIKE '30[0-9]{2}'
  )
ORDER BY value_desc
LIMIT 200;



%%sql

SELECT
    activity_header_id,
    group_id,
    group_desc,
    raw_session_date
FROM test_temp_wip_form_answer_date_lookup
WHERE raw_session_date IS NOT NULL
  AND (
        raw_session_date RLIKE '21[0-9]{2}'
     OR raw_session_date RLIKE '22[0-9]{2}'
     OR raw_session_date RLIKE '23[0-9]{2}'
     OR raw_session_date RLIKE '24[0-9]{2}'
     OR raw_session_date RLIKE '25[0-9]{2}'
     OR raw_session_date RLIKE '29[0-9]{2}'
     OR raw_session_date RLIKE '30[0-9]{2}'
  )
ORDER BY raw_session_date
LIMIT 200;




%%sql

SELECT
    activity_header_id,
    group_id,
    group_desc,
    raw_session_date,
    clean_session_date,
    parsed_form_ans_date
FROM test_temp_wip_form_answer_parsed_date_lookup
WHERE parsed_form_ans_date > ADD_MONTHS(CURRENT_DATE(), 120)
   OR parsed_form_ans_date < DATE '1900-01-01'
ORDER BY parsed_form_ans_date, raw_session_date
LIMIT 200;