%%sql

WITH cleaned AS (
    SELECT
        activity_header_id,
        group_id,
        group_desc,
        raw_session_date,

        TRIM(
            REGEXP_REPLACE(
                REGEXP_REPLACE(
                    REGEXP_REPLACE(
                        REGEXP_REPLACE(INITCAP(TRIM(raw_session_date)), '[–—]', '-'),
                        '^(Monday|Tuesday|Wednesday|Thursday|Friday|Saturday|Sunday)\\s+', ''
                    ),
                    '([0-9]{1,2})(st|nd|rd|th)\\b', '$1'
                ),
                ',', ''
            )
        ) AS clean_session_date
    FROM temp_wip_form_answer_date_lookup
),

parsed AS (
    SELECT
        activity_header_id,
        group_id,
        group_desc,
        raw_session_date,
        clean_session_date,

        CASE
            WHEN clean_session_date RLIKE '^[0-9]{1,2}/[0-9]{1,2}/[0-9]{4}.*$'
                THEN REGEXP_EXTRACT(clean_session_date, '^([0-9]{1,2}/[0-9]{1,2}/[0-9]{4})', 1)
            WHEN clean_session_date RLIKE '^[0-9]{1,2}/[0-9]{1,2}/[0-9]{2}.*$'
                THEN REGEXP_EXTRACT(clean_session_date, '^([0-9]{1,2}/[0-9]{1,2}/[0-9]{2})', 1)

            WHEN clean_session_date RLIKE '^[0-9]{1,2}\\.[0-9]{1,2}\\.[0-9]{4}.*$'
                THEN REGEXP_EXTRACT(clean_session_date, '^([0-9]{1,2}\\.[0-9]{1,2}\\.[0-9]{4})', 1)
            WHEN clean_session_date RLIKE '^[0-9]{1,2}\\.[0-9]{1,2}\\.[0-9]{2}.*$'
                THEN REGEXP_EXTRACT(clean_session_date, '^([0-9]{1,2}\\.[0-9]{1,2}\\.[0-9]{2})', 1)

            WHEN clean_session_date RLIKE '^[0-9]{1,2}-[0-9]{1,2}-[0-9]{4}.*$'
                THEN REGEXP_EXTRACT(clean_session_date, '^([0-9]{1,2}-[0-9]{1,2}-[0-9]{4})', 1)
            WHEN clean_session_date RLIKE '^[0-9]{1,2}-[0-9]{1,2}-[0-9]{2}.*$'
                THEN REGEXP_EXTRACT(clean_session_date, '^([0-9]{1,2}-[0-9]{1,2}-[0-9]{2})', 1)

            WHEN clean_session_date RLIKE '^[0-9]{1,2} [A-Za-z]{3} [0-9]{4}.*$'
                THEN REGEXP_EXTRACT(clean_session_date, '^([0-9]{1,2} [A-Za-z]{3} [0-9]{4})', 1)
            WHEN clean_session_date RLIKE '^[0-9]{1,2} [A-Za-z]{3} [0-9]{2}.*$'
                THEN REGEXP_EXTRACT(clean_session_date, '^([0-9]{1,2} [A-Za-z]{3} [0-9]{2})', 1)

            WHEN clean_session_date RLIKE '^[0-9]{1,2} [A-Za-z]+ [0-9]{4}.*$'
                THEN REGEXP_EXTRACT(clean_session_date, '^([0-9]{1,2} [A-Za-z]+ [0-9]{4})', 1)
            WHEN clean_session_date RLIKE '^[0-9]{1,2} [A-Za-z]+ [0-9]{2}.*$'
                THEN REGEXP_EXTRACT(clean_session_date, '^([0-9]{1,2} [A-Za-z]+ [0-9]{2})', 1)

            WHEN clean_session_date RLIKE '^[A-Za-z]{3} [0-9]{1,2} [0-9]{4}.*$'
                THEN REGEXP_EXTRACT(clean_session_date, '^([A-Za-z]{3} [0-9]{1,2} [0-9]{4})', 1)
            WHEN clean_session_date RLIKE '^[A-Za-z]+ [0-9]{1,2} [0-9]{4}.*$'
                THEN REGEXP_EXTRACT(clean_session_date, '^([A-Za-z]+ [0-9]{1,2} [0-9]{4})', 1)

            ELSE NULL
        END AS extracted_date_text,

        CASE
            WHEN clean_session_date RLIKE '^[0-9]{1,2}/[0-9]{1,2}/[0-9]{4}.*$' THEN 'slash_d_M_yyyy'
            WHEN clean_session_date RLIKE '^[0-9]{1,2}/[0-9]{1,2}/[0-9]{2}.*$' THEN 'slash_d_M_yy'
            WHEN clean_session_date RLIKE '^[0-9]{1,2}\\.[0-9]{1,2}\\.[0-9]{4}.*$' THEN 'dot_d_M_yyyy'
            WHEN clean_session_date RLIKE '^[0-9]{1,2}\\.[0-9]{1,2}\\.[0-9]{2}.*$' THEN 'dot_d_M_yy'
            WHEN clean_session_date RLIKE '^[0-9]{1,2}-[0-9]{1,2}-[0-9]{4}.*$' THEN 'dash_d_M_yyyy'
            WHEN clean_session_date RLIKE '^[0-9]{1,2}-[0-9]{1,2}-[0-9]{2}.*$' THEN 'dash_d_M_yy'
            WHEN clean_session_date RLIKE '^[0-9]{1,2} [A-Za-z]{3} [0-9]{4}.*$' THEN 'day_shortmonth_yyyy'
            WHEN clean_session_date RLIKE '^[0-9]{1,2} [A-Za-z]{3} [0-9]{2}.*$' THEN 'day_shortmonth_yy'
            WHEN clean_session_date RLIKE '^[0-9]{1,2} [A-Za-z]+ [0-9]{4}.*$' THEN 'day_longmonth_yyyy'
            WHEN clean_session_date RLIKE '^[0-9]{1,2} [A-Za-z]+ [0-9]{2}.*$' THEN 'day_longmonth_yy'
            WHEN clean_session_date RLIKE '^[A-Za-z]{3} [0-9]{1,2} [0-9]{4}.*$' THEN 'shortmonth_day_yyyy'
            WHEN clean_session_date RLIKE '^[A-Za-z]+ [0-9]{1,2} [0-9]{4}.*$' THEN 'longmonth_day_yyyy'
            ELSE 'not_matched'
        END AS parse_rule,

        CASE
            WHEN clean_session_date RLIKE '^[0-9]{1,2}/[0-9]{1,2}/[0-9]{4}.*$'
                THEN TO_DATE(FROM_UNIXTIME(UNIX_TIMESTAMP(REGEXP_EXTRACT(clean_session_date, '^([0-9]{1,2}/[0-9]{1,2}/[0-9]{4})', 1), 'd/M/yyyy')))
            WHEN clean_session_date RLIKE '^[0-9]{1,2}/[0-9]{1,2}/[0-9]{2}.*$'
                THEN TO_DATE(FROM_UNIXTIME(UNIX_TIMESTAMP(REGEXP_EXTRACT(clean_session_date, '^([0-9]{1,2}/[0-9]{1,2}/[0-9]{2})', 1), 'd/M/yy')))

            WHEN clean_session_date RLIKE '^[0-9]{1,2}\\.[0-9]{1,2}\\.[0-9]{4}.*$'
                THEN TO_DATE(FROM_UNIXTIME(UNIX_TIMESTAMP(REGEXP_EXTRACT(clean_session_date, '^([0-9]{1,2}\\.[0-9]{1,2}\\.[0-9]{4})', 1), 'd.M.yyyy')))
            WHEN clean_session_date RLIKE '^[0-9]{1,2}\\.[0-9]{1,2}\\.[0-9]{2}.*$'
                THEN TO_DATE(FROM_UNIXTIME(UNIX_TIMESTAMP(REGEXP_EXTRACT(clean_session_date, '^([0-9]{1,2}\\.[0-9]{1,2}\\.[0-9]{2})', 1), 'd.M.yy')))

            WHEN clean_session_date RLIKE '^[0-9]{1,2}-[0-9]{1,2}-[0-9]{4}.*$'
                THEN TO_DATE(FROM_UNIXTIME(UNIX_TIMESTAMP(REGEXP_EXTRACT(clean_session_date, '^([0-9]{1,2}-[0-9]{1,2}-[0-9]{4})', 1), 'd-M-yyyy')))
            WHEN clean_session_date RLIKE '^[0-9]{1,2}-[0-9]{1,2}-[0-9]{2}.*$'
                THEN TO_DATE(FROM_UNIXTIME(UNIX_TIMESTAMP(REGEXP_EXTRACT(clean_session_date, '^([0-9]{1,2}-[0-9]{1,2}-[0-9]{2})', 1), 'd-M-yy')))

            WHEN clean_session_date RLIKE '^[0-9]{1,2} [A-Za-z]{3} [0-9]{4}.*$'
                THEN TO_DATE(FROM_UNIXTIME(UNIX_TIMESTAMP(REGEXP_EXTRACT(clean_session_date, '^([0-9]{1,2} [A-Za-z]{3} [0-9]{4})', 1), 'd MMM yyyy')))
            WHEN clean_session_date RLIKE '^[0-9]{1,2} [A-Za-z]{3} [0-9]{2}.*$'
                THEN TO_DATE(FROM_UNIXTIME(UNIX_TIMESTAMP(REGEXP_EXTRACT(clean_session_date, '^([0-9]{1,2} [A-Za-z]{3} [0-9]{2})', 1), 'd MMM yy')))

            WHEN clean_session_date RLIKE '^[0-9]{1,2} [A-Za-z]+ [0-9]{4}.*$'
                THEN TO_DATE(FROM_UNIXTIME(UNIX_TIMESTAMP(REGEXP_EXTRACT(clean_session_date, '^([0-9]{1,2} [A-Za-z]+ [0-9]{4})', 1), 'd MMMM yyyy')))
            WHEN clean_session_date RLIKE '^[0-9]{1,2} [A-Za-z]+ [0-9]{2}.*$'
                THEN TO_DATE(FROM_UNIXTIME(UNIX_TIMESTAMP(REGEXP_EXTRACT(clean_session_date, '^([0-9]{1,2} [A-Za-z]+ [0-9]{2})', 1), 'd MMMM yy')))

            WHEN clean_session_date RLIKE '^[A-Za-z]{3} [0-9]{1,2} [0-9]{4}.*$'
                THEN TO_DATE(FROM_UNIXTIME(UNIX_TIMESTAMP(REGEXP_EXTRACT(clean_session_date, '^([A-Za-z]{3} [0-9]{1,2} [0-9]{4})', 1), 'MMM d yyyy')))
            WHEN clean_session_date RLIKE '^[A-Za-z]+ [0-9]{1,2} [0-9]{4}.*$'
                THEN TO_DATE(FROM_UNIXTIME(UNIX_TIMESTAMP(REGEXP_EXTRACT(clean_session_date, '^([A-Za-z]+ [0-9]{1,2} [0-9]{4})', 1), 'MMMM d yyyy')))

            ELSE NULL
        END AS raw_parsed_form_ans_date

    FROM cleaned
)

SELECT
    activity_header_id,
    group_id,
    group_desc,
    raw_session_date,
    clean_session_date,
    extracted_date_text,
    parse_rule,
    raw_parsed_form_ans_date
FROM parsed
WHERE raw_parsed_form_ans_date < DATE '1900-01-01'
   OR raw_parsed_form_ans_date > ADD_MONTHS(CURRENT_DATE(), 120)
ORDER BY raw_parsed_form_ans_date, raw_session_date
LIMIT 200;