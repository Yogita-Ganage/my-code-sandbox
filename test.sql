SELECT
    activity_header_id,
    group_id,
    group_desc,
    raw_session_date,
    clean_session_date,

    CASE
        WHEN COALESCE(v1_parsed_date, v2_fallback_parsed_date)
             BETWEEN DATE '1899-12-30' AND DATE '9999-12-31'
        THEN COALESCE(v1_parsed_date, v2_fallback_parsed_date)
        ELSE NULL
    END AS parsed_form_ans_date

FROM parsed;