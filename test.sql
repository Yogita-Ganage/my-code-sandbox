%%sql

SELECT
    COUNT(*) AS different_parsed_date_rows
FROM temp_wip_form_answer_parsed_date_lookup_v1_start_match v1
INNER JOIN temp_wip_form_answer_parsed_date_lookup_v2_extract_anywhere v2
    ON v1.activity_header_id = v2.activity_header_id
   AND v1.group_id = v2.group_id
   AND TRIM(LOWER(v1.group_desc)) = TRIM(LOWER(v2.group_desc))
   AND COALESCE(v1.raw_session_date, '') = COALESCE(v2.raw_session_date, '')
WHERE v1.parsed_form_ans_date IS NOT NULL
  AND v2.parsed_form_ans_date IS NOT NULL
  AND v1.parsed_form_ans_date <> v2.parsed_form_ans_date;







v1--

%%sql

DROP TABLE IF EXISTS temp_wip_form_answer_parsed_date_lookup_v1_start_match;

CREATE TABLE temp_wip_form_answer_parsed_date_lookup_v1_start_match AS
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
                'Sept\\.?',
                'Sep'
            )
        ) AS clean_session_date

    FROM temp_wip_form_answer_date_lookup
)

SELECT
    activity_header_id,
    group_id,
    group_desc,
    raw_session_date,
    clean_session_date,

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
    END AS parsed_form_ans_date

FROM cleaned;



-------------v2------------

%%sql

DROP TABLE IF EXISTS temp_wip_form_answer_parsed_date_lookup_v2_extract_anywhere;

CREATE TABLE temp_wip_form_answer_parsed_date_lookup_v2_extract_anywhere AS
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
                'Sept\\.?',
                'Sep'
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
            WHEN clean_session_date RLIKE '[0-9]{1,2}/[0-9]{1,2}/[0-9]{4}'
                THEN REGEXP_EXTRACT(clean_session_date, '([0-9]{1,2}/[0-9]{1,2}/[0-9]{4})', 1)

            WHEN clean_session_date RLIKE '[0-9]{1,2}/[0-9]{1,2}/[0-9]{2}'
                THEN REGEXP_EXTRACT(clean_session_date, '([0-9]{1,2}/[0-9]{1,2}/[0-9]{2})', 1)

            WHEN clean_session_date RLIKE '[0-9]{1,2}\\.[0-9]{1,2}\\.[0-9]{4}'
                THEN REGEXP_EXTRACT(clean_session_date, '([0-9]{1,2}\\.[0-9]{1,2}\\.[0-9]{4})', 1)

            WHEN clean_session_date RLIKE '[0-9]{1,2}\\.[0-9]{1,2}\\.[0-9]{2}'
                THEN REGEXP_EXTRACT(clean_session_date, '([0-9]{1,2}\\.[0-9]{1,2}\\.[0-9]{2})', 1)

            WHEN clean_session_date RLIKE '[0-9]{1,2}-[0-9]{1,2}-[0-9]{4}'
                THEN REGEXP_EXTRACT(clean_session_date, '([0-9]{1,2}-[0-9]{1,2}-[0-9]{4})', 1)

            WHEN clean_session_date RLIKE '[0-9]{1,2}-[0-9]{1,2}-[0-9]{2}'
                THEN REGEXP_EXTRACT(clean_session_date, '([0-9]{1,2}-[0-9]{1,2}-[0-9]{2})', 1)

            WHEN clean_session_date RLIKE '[0-9]{1,2} [A-Za-z]{3} [0-9]{4}'
                THEN REGEXP_EXTRACT(clean_session_date, '([0-9]{1,2} [A-Za-z]{3} [0-9]{4})', 1)

            WHEN clean_session_date RLIKE '[0-9]{1,2} [A-Za-z]{3} [0-9]{2}'
                THEN REGEXP_EXTRACT(clean_session_date, '([0-9]{1,2} [A-Za-z]{3} [0-9]{2})', 1)

            WHEN clean_session_date RLIKE '[0-9]{1,2} [A-Za-z]+ [0-9]{4}'
                THEN REGEXP_EXTRACT(clean_session_date, '([0-9]{1,2} [A-Za-z]+ [0-9]{4})', 1)

            WHEN clean_session_date RLIKE '[0-9]{1,2} [A-Za-z]+ [0-9]{2}'
                THEN REGEXP_EXTRACT(clean_session_date, '([0-9]{1,2} [A-Za-z]+ [0-9]{2})', 1)

            WHEN clean_session_date RLIKE '[A-Za-z]{3} [0-9]{1,2} [0-9]{4}'
                THEN REGEXP_EXTRACT(clean_session_date, '([A-Za-z]{3} [0-9]{1,2} [0-9]{4})', 1)

            WHEN clean_session_date RLIKE '[A-Za-z]+ [0-9]{1,2} [0-9]{4}'
                THEN REGEXP_EXTRACT(clean_session_date, '([A-Za-z]+ [0-9]{1,2} [0-9]{4})', 1)

            ELSE NULL
        END AS extracted_date_text,

        CASE
            WHEN clean_session_date RLIKE '[0-9]{1,2}/[0-9]{1,2}/[0-9]{4}' THEN 'slash_d_M_yyyy'
            WHEN clean_session_date RLIKE '[0-9]{1,2}/[0-9]{1,2}/[0-9]{2}' THEN 'slash_d_M_yy'

            WHEN clean_session_date RLIKE '[0-9]{1,2}\\.[0-9]{1,2}\\.[0-9]{4}' THEN 'dot_d_M_yyyy'
            WHEN clean_session_date RLIKE '[0-9]{1,2}\\.[0-9]{1,2}\\.[0-9]{2}' THEN 'dot_d_M_yy'

            WHEN clean_session_date RLIKE '[0-9]{1,2}-[0-9]{1,2}-[0-9]{4}' THEN 'dash_d_M_yyyy'
            WHEN clean_session_date RLIKE '[0-9]{1,2}-[0-9]{1,2}-[0-9]{2}' THEN 'dash_d_M_yy'

            WHEN clean_session_date RLIKE '[0-9]{1,2} [A-Za-z]{3} [0-9]{4}' THEN 'day_shortmonth_yyyy'
            WHEN clean_session_date RLIKE '[0-9]{1,2} [A-Za-z]{3} [0-9]{2}' THEN 'day_shortmonth_yy'

            WHEN clean_session_date RLIKE '[0-9]{1,2} [A-Za-z]+ [0-9]{4}' THEN 'day_longmonth_yyyy'
            WHEN clean_session_date RLIKE '[0-9]{1,2} [A-Za-z]+ [0-9]{2}' THEN 'day_longmonth_yy'

            WHEN clean_session_date RLIKE '[A-Za-z]{3} [0-9]{1,2} [0-9]{4}' THEN 'shortmonth_day_yyyy'
            WHEN clean_session_date RLIKE '[A-Za-z]+ [0-9]{1,2} [0-9]{4}' THEN 'longmonth_day_yyyy'

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
        WHEN parse_rule = 'slash_d_M_yyyy' THEN TO_DATE(FROM_UNIXTIME(UNIX_TIMESTAMP(extracted_date_text, 'd/M/yyyy')))
        WHEN parse_rule = 'slash_d_M_yy' THEN TO_DATE(FROM_UNIXTIME(UNIX_TIMESTAMP(extracted_date_text, 'd/M/yy')))

        WHEN parse_rule = 'dot_d_M_yyyy' THEN TO_DATE(FROM_UNIXTIME(UNIX_TIMESTAMP(extracted_date_text, 'd.M.yyyy')))
        WHEN parse_rule = 'dot_d_M_yy' THEN TO_DATE(FROM_UNIXTIME(UNIX_TIMESTAMP(extracted_date_text, 'd.M.yy')))

        WHEN parse_rule = 'dash_d_M_yyyy' THEN TO_DATE(FROM_UNIXTIME(UNIX_TIMESTAMP(extracted_date_text, 'd-M-yyyy')))
        WHEN parse_rule = 'dash_d_M_yy' THEN TO_DATE(FROM_UNIXTIME(UNIX_TIMESTAMP(extracted_date_text, 'd-M-yy')))

        WHEN parse_rule = 'day_shortmonth_yyyy' THEN TO_DATE(FROM_UNIXTIME(UNIX_TIMESTAMP(extracted_date_text, 'd MMM yyyy')))
        WHEN parse_rule = 'day_shortmonth_yy' THEN TO_DATE(FROM_UNIXTIME(UNIX_TIMESTAMP(extracted_date_text, 'd MMM yy')))

        WHEN parse_rule = 'day_longmonth_yyyy' THEN TO_DATE(FROM_UNIXTIME(UNIX_TIMESTAMP(extracted_date_text, 'd MMMM yyyy')))
        WHEN parse_rule = 'day_longmonth_yy' THEN TO_DATE(FROM_UNIXTIME(UNIX_TIMESTAMP(extracted_date_text, 'd MMMM yy')))

        WHEN parse_rule = 'shortmonth_day_yyyy' THEN TO_DATE(FROM_UNIXTIME(UNIX_TIMESTAMP(extracted_date_text, 'MMM d yyyy')))
        WHEN parse_rule = 'longmonth_day_yyyy' THEN TO_DATE(FROM_UNIXTIME(UNIX_TIMESTAMP(extracted_date_text, 'MMMM d yyyy')))

        ELSE NULL
    END AS parsed_form_ans_date

FROM extracted;



------count comparisn----

%%sql

SELECT
    'v1_start_match' AS version_name,
    COUNT(*) AS total_rows,
    COUNT(parsed_form_ans_date) AS parsed_rows,
    COUNT(*) - COUNT(parsed_form_ans_date) AS not_parsed_rows
FROM temp_wip_form_answer_parsed_date_lookup_v1_start_match

UNION ALL

SELECT
    'v2_extract_anywhere' AS version_name,
    COUNT(*) AS total_rows,
    COUNT(parsed_form_ans_date) AS parsed_rows,
    COUNT(*) - COUNT(parsed_form_ans_date) AS not_parsed_rows
FROM temp_wip_form_answer_parsed_date_lookup_v2_extract_anywhere;








-----v2 p v1 not--------

%%sql

SELECT
    v1.activity_header_id,
    v1.group_id,
    v1.group_desc,
    v1.raw_session_date,
    v1.clean_session_date AS v1_clean_session_date,
    v1.parsed_form_ans_date AS v1_parsed_date,
    v2.clean_session_date AS v2_clean_session_date,
    v2.extracted_date_text AS v2_extracted_date_text,
    v2.parse_rule AS v2_parse_rule,
    v2.parsed_form_ans_date AS v2_parsed_date
FROM temp_wip_form_answer_parsed_date_lookup_v1_start_match v1
INNER JOIN temp_wip_form_answer_parsed_date_lookup_v2_extract_anywhere v2
    ON v1.activity_header_id = v2.activity_header_id
   AND v1.group_id = v2.group_id
   AND TRIM(LOWER(v1.group_desc)) = TRIM(LOWER(v2.group_desc))
   AND COALESCE(v1.raw_session_date, '') = COALESCE(v2.raw_session_date, '')
WHERE v1.parsed_form_ans_date IS NULL
  AND v2.parsed_form_ans_date IS NOT NULL
ORDER BY v1.raw_session_date
LIMIT 200;


------v1 par v2 not---
%%sql

SELECT
    v1.activity_header_id,
    v1.group_id,
    v1.group_desc,
    v1.raw_session_date,
    v1.clean_session_date AS v1_clean_session_date,
    v1.parsed_form_ans_date AS v1_parsed_date,
    v2.clean_session_date AS v2_clean_session_date,
    v2.extracted_date_text AS v2_extracted_date_text,
    v2.parse_rule AS v2_parse_rule,
    v2.parsed_form_ans_date AS v2_parsed_date
FROM temp_wip_form_answer_parsed_date_lookup_v1_start_match v1
INNER JOIN temp_wip_form_answer_parsed_date_lookup_v2_extract_anywhere v2
    ON v1.activity_header_id = v2.activity_header_id
   AND v1.group_id = v2.group_id
   AND TRIM(LOWER(v1.group_desc)) = TRIM(LOWER(v2.group_desc))
   AND COALESCE(v1.raw_session_date, '') = COALESCE(v2.raw_session_date, '')
WHERE v1.parsed_form_ans_date IS NOT NULL
  AND v2.parsed_form_ans_date IS NULL
ORDER BY v1.raw_session_date
LIMIT 200;



sam rowdiff prs
%%sql

SELECT
    v1.activity_header_id,
    v1.group_id,
    v1.group_desc,
    v1.raw_session_date,
    v1.clean_session_date AS v1_clean_session_date,
    v1.parsed_form_ans_date AS v1_parsed_date,
    v2.clean_session_date AS v2_clean_session_date,
    v2.extracted_date_text AS v2_extracted_date_text,
    v2.parse_rule AS v2_parse_rule,
    v2.parsed_form_ans_date AS v2_parsed_date
FROM temp_wip_form_answer_parsed_date_lookup_v1_start_match v1
INNER JOIN temp_wip_form_answer_parsed_date_lookup_v2_extract_anywhere v2
    ON v1.activity_header_id = v2.activity_header_id
   AND v1.group_id = v2.group_id
   AND TRIM(LOWER(v1.group_desc)) = TRIM(LOWER(v2.group_desc))
   AND COALESCE(v1.raw_session_date, '') = COALESCE(v2.raw_session_date, '')
WHERE v1.parsed_form_ans_date IS NOT NULL
  AND v2.parsed_form_ans_date IS NOT NULL
  AND v1.parsed_form_ans_date <> v2.parsed_form_ans_date
ORDER BY v1.raw_session_date
LIMIT 200;




%%sql

SELECT
    COUNT(*) AS total_rows,
    COUNT(parsed_form_ans_date) AS parsed_rows,
    COUNT(*) - COUNT(parsed_form_ans_date) AS not_parsed_rows
FROM temp_wip_form_answer_parsed_date_lookup;


-------

%%sql

SELECT
    raw_session_date,
    clean_session_date,
    COUNT(*) AS row_count
FROM temp_wip_form_answer_parsed_date_lookup
WHERE parsed_form_ans_date IS NULL
GROUP BY raw_session_date, clean_session_date
ORDER BY row_count DESC
LIMIT 100;




%%sql

SELECT
    raw_session_date,
    clean_session_date,
    extracted_date_text,
    parse_rule,
    parsed_form_ans_date
FROM temp_wip_form_answer_parsed_date_lookup
WHERE LOWER(raw_session_date) LIKE '%17/3/22%'
   OR raw_session_date IN (
        '03/12/2021',
        '30/04/2022',
        '25/11/2022',
        '01.08.2205'
   )
LIMIT 100;

----------

