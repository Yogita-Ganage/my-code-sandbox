%%sql

SELECT
    raw_session_date,
    clean_session_date,
    parsed_form_ans_date
FROM temp_wip_form_answer_parsed_date_lookup
WHERE raw_session_date IN (
    '17/3/22',
    '17/03/2022',
    '17.03.22',
    '17-03-2022',
    '17th March 2022',
    'Friday 17th March 2022',
    'see 17/3/22',
    'DNA final session',
    'SC review'
)
ORDER BY raw_session_date;


-------




%%sql

DROP TABLE IF EXISTS temp_wip_form_answer_parsed_date_lookup;

CREATE TABLE temp_wip_form_answer_parsed_date_lookup AS
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
                        REGEXP_REPLACE(REGEXP_REPLACE(INITCAP(TRIM(raw_session_date)), '[–—]', '-'), ',', ''),
                        '^(Monday|Tuesday|Wednesday|Thursday|Friday|Saturday|Sunday)\\s+', ''
                    ),
                    '([0-9]{1,2})(st|nd|rd|th)\\b', '$1'
                ),
                '\\bSept\\.?\\b', 'Sep'
            )
        ) AS clean_session_date

    FROM temp_wip_form_answer_date_lookup
),

extracted AS (
    SELECT
        activity_header_id,
        group_id,
        group_desc,
        raw_session_date,
        clean_session_date,

        CASE
            WHEN clean_session_date RLIKE '\\b[0-9]{1,2}/[0-9]{1,2}/[0-9]{4}\\b'
                THEN REGEXP_EXTRACT(clean_session_date, '\\b([0-9]{1,2}/[0-9]{1,2}/[0-9]{4})\\b', 1)

            WHEN clean_session_date RLIKE '\\b[0-9]{1,2}/[0-9]{1,2}/[0-9]{2}\\b'
                THEN REGEXP_EXTRACT(clean_session_date, '\\b([0-9]{1,2}/[0-9]{1,2}/[0-9]{2})\\b', 1)

            WHEN clean_session_date RLIKE '\\b[0-9]{1,2}\\.[0-9]{1,2}\\.[0-9]{4}\\b'
                THEN REGEXP_EXTRACT(clean_session_date, '\\b([0-9]{1,2}\\.[0-9]{1,2}\\.[0-9]{4})\\b', 1)

            WHEN clean_session_date RLIKE '\\b[0-9]{1,2}\\.[0-9]{1,2}\\.[0-9]{2}\\b'
                THEN REGEXP_EXTRACT(clean_session_date, '\\b([0-9]{1,2}\\.[0-9]{1,2}\\.[0-9]{2})\\b', 1)

            WHEN clean_session_date RLIKE '\\b[0-9]{1,2}-[0-9]{1,2}-[0-9]{4}\\b'
                THEN REGEXP_EXTRACT(clean_session_date, '\\b([0-9]{1,2}-[0-9]{1,2}-[0-9]{4})\\b', 1)

            WHEN clean_session_date RLIKE '\\b[0-9]{1,2}-[0-9]{1,2}-[0-9]{2}\\b'
                THEN REGEXP_EXTRACT(clean_session_date, '\\b([0-9]{1,2}-[0-9]{1,2}-[0-9]{2})\\b', 1)

            WHEN clean_session_date RLIKE '\\b[0-9]{1,2} [A-Za-z]{3} [0-9]{4}\\b'
                THEN REGEXP_EXTRACT(clean_session_date, '\\b([0-9]{1,2} [A-Za-z]{3} [0-9]{4})\\b', 1)

            WHEN clean_session_date RLIKE '\\b[0-9]{1,2} [A-Za-z]{3} [0-9]{2}\\b'
                THEN REGEXP_EXTRACT(clean_session_date, '\\b([0-9]{1,2} [A-Za-z]{3} [0-9]{2})\\b', 1)

            WHEN clean_session_date RLIKE '\\b[0-9]{1,2} [A-Za-z]+ [0-9]{4}\\b'
                THEN REGEXP_EXTRACT(clean_session_date, '\\b([0-9]{1,2} [A-Za-z]+ [0-9]{4})\\b', 1)

            WHEN clean_session_date RLIKE '\\b[0-9]{1,2} [A-Za-z]+ [0-9]{2}\\b'
                THEN REGEXP_EXTRACT(clean_session_date, '\\b([0-9]{1,2} [A-Za-z]+ [0-9]{2})\\b', 1)

            WHEN clean_session_date RLIKE '\\b[A-Za-z]{3} [0-9]{1,2} [0-9]{4}\\b'
                THEN REGEXP_EXTRACT(clean_session_date, '\\b([A-Za-z]{3} [0-9]{1,2} [0-9]{4})\\b', 1)

            WHEN clean_session_date RLIKE '\\b[A-Za-z]+ [0-9]{1,2} [0-9]{4}\\b'
                THEN REGEXP_EXTRACT(clean_session_date, '\\b([A-Za-z]+ [0-9]{1,2} [0-9]{4})\\b', 1)

            ELSE NULL
        END AS extracted_date_text,

        CASE
            WHEN clean_session_date RLIKE '\\b[0-9]{1,2}/[0-9]{1,2}/[0-9]{4}\\b' THEN 'slash_d_M_yyyy'
            WHEN clean_session_date RLIKE '\\b[0-9]{1,2}/[0-9]{1,2}/[0-9]{2}\\b' THEN 'slash_d_M_yy'

            WHEN clean_session_date RLIKE '\\b[0-9]{1,2}\\.[0-9]{1,2}\\.[0-9]{4}\\b' THEN 'dot_d_M_yyyy'
            WHEN clean_session_date RLIKE '\\b[0-9]{1,2}\\.[0-9]{1,2}\\.[0-9]{2}\\b' THEN 'dot_d_M_yy'

            WHEN clean_session_date RLIKE '\\b[0-9]{1,2}-[0-9]{1,2}-[0-9]{4}\\b' THEN 'dash_d_M_yyyy'
            WHEN clean_session_date RLIKE '\\b[0-9]{1,2}-[0-9]{1,2}-[0-9]{2}\\b' THEN 'dash_d_M_yy'

            WHEN clean_session_date RLIKE '\\b[0-9]{1,2} [A-Za-z]{3} [0-9]{4}\\b' THEN 'day_shortmonth_yyyy'
            WHEN clean_session_date RLIKE '\\b[0-9]{1,2} [A-Za-z]{3} [0-9]{2}\\b' THEN 'day_shortmonth_yy'

            WHEN clean_session_date RLIKE '\\b[0-9]{1,2} [A-Za-z]+ [0-9]{4}\\b' THEN 'day_longmonth_yyyy'
            WHEN clean_session_date RLIKE '\\b[0-9]{1,2} [A-Za-z]+ [0-9]{2}\\b' THEN 'day_longmonth_yy'

            WHEN clean_session_date RLIKE '\\b[A-Za-z]{3} [0-9]{1,2} [0-9]{4}\\b' THEN 'shortmonth_day_yyyy'
            WHEN clean_session_date RLIKE '\\b[A-Za-z]+ [0-9]{1,2} [0-9]{4}\\b' THEN 'longmonth_day_yyyy'

            ELSE 'not_matched'
        END AS parse_rule

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

    CASE
        WHEN parse_rule = 'slash_d_M_yyyy'
            THEN TO_DATE(FROM_UNIXTIME(UNIX_TIMESTAMP(extracted_date_text, 'd/M/yyyy')))

        WHEN parse_rule = 'slash_d_M_yy'
            THEN TO_DATE(FROM_UNIXTIME(UNIX_TIMESTAMP(extracted_date_text, 'd/M/yy')))

        WHEN parse_rule = 'dot_d_M_yyyy'
            THEN TO_DATE(FROM_UNIXTIME(UNIX_TIMESTAMP(extracted_date_text, 'd.M.yyyy')))

        WHEN parse_rule = 'dot_d_M_yy'
            THEN TO_DATE(FROM_UNIXTIME(UNIX_TIMESTAMP(extracted_date_text, 'd.M.yy')))

        WHEN parse_rule = 'dash_d_M_yyyy'
            THEN TO_DATE(FROM_UNIXTIME(UNIX_TIMESTAMP(extracted_date_text, 'd-M-yyyy')))

        WHEN parse_rule = 'dash_d_M_yy'
            THEN TO_DATE(FROM_UNIXTIME(UNIX_TIMESTAMP(extracted_date_text, 'd-M-yy')))

        WHEN parse_rule = 'day_shortmonth_yyyy'
            THEN TO_DATE(FROM_UNIXTIME(UNIX_TIMESTAMP(extracted_date_text, 'd MMM yyyy')))

        WHEN parse_rule = 'day_shortmonth_yy'
            THEN TO_DATE(FROM_UNIXTIME(UNIX_TIMESTAMP(extracted_date_text, 'd MMM yy')))

        WHEN parse_rule = 'day_longmonth_yyyy'
            THEN TO_DATE(FROM_UNIXTIME(UNIX_TIMESTAMP(extracted_date_text, 'd MMMM yyyy')))

        WHEN parse_rule = 'day_longmonth_yy'
            THEN TO_DATE(FROM_UNIXTIME(UNIX_TIMESTAMP(extracted_date_text, 'd MMMM yy')))

        WHEN parse_rule = 'shortmonth_day_yyyy'
            THEN TO_DATE(FROM_UNIXTIME(UNIX_TIMESTAMP(extracted_date_text, 'MMM d yyyy')))

        WHEN parse_rule = 'longmonth_day_yyyy'
            THEN TO_DATE(FROM_UNIXTIME(UNIX_TIMESTAMP(extracted_date_text, 'MMMM d yyyy')))

        ELSE NULL
    END AS parsed_form_ans_date

FROM extracted;