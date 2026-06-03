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
                'Sept\\.?',
                'Sep'
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

        -- V1: conservative start-match parsing
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
        END AS v1_parsed_date,

        -- V2 fallback: extract date from anywhere in free text
        CASE
            WHEN clean_session_date RLIKE '[0-9]{1,2}/[0-9]{1,2}/[0-9]{4}'
                THEN TO_DATE(FROM_UNIXTIME(UNIX_TIMESTAMP(REGEXP_EXTRACT(clean_session_date, '([0-9]{1,2}/[0-9]{1,2}/[0-9]{4})', 1), 'd/M/yyyy')))

            WHEN clean_session_date RLIKE '[0-9]{1,2}/[0-9]{1,2}/[0-9]{2}'
                THEN TO_DATE(FROM_UNIXTIME(UNIX_TIMESTAMP(REGEXP_EXTRACT(clean_session_date, '([0-9]{1,2}/[0-9]{1,2}/[0-9]{2})', 1), 'd/M/yy')))

            WHEN clean_session_date RLIKE '[0-9]{1,2}\\.[0-9]{1,2}\\.[0-9]{4}'
                THEN TO_DATE(FROM_UNIXTIME(UNIX_TIMESTAMP(REGEXP_EXTRACT(clean_session_date, '([0-9]{1,2}\\.[0-9]{1,2}\\.[0-9]{4})', 1), 'd.M.yyyy')))

            WHEN clean_session_date RLIKE '[0-9]{1,2}\\.[0-9]{1,2}\\.[0-9]{2}'
                THEN TO_DATE(FROM_UNIXTIME(UNIX_TIMESTAMP(REGEXP_EXTRACT(clean_session_date, '([0-9]{1,2}\\.[0-9]{1,2}\\.[0-9]{2})', 1), 'd.M.yy')))

            WHEN clean_session_date RLIKE '[0-9]{1,2}-[0-9]{1,2}-[0-9]{4}'
                THEN TO_DATE(FROM_UNIXTIME(UNIX_TIMESTAMP(REGEXP_EXTRACT(clean_session_date, '([0-9]{1,2}-[0-9]{1,2}-[0-9]{4})', 1), 'd-M-yyyy')))

            WHEN clean_session_date RLIKE '[0-9]{1,2}-[0-9]{1,2}-[0-9]{2}'
                THEN TO_DATE(FROM_UNIXTIME(UNIX_TIMESTAMP(REGEXP_EXTRACT(clean_session_date, '([0-9]{1,2}-[0-9]{1,2}-[0-9]{2})', 1), 'd-M-yy')))

            WHEN clean_session_date RLIKE '[0-9]{1,2} [A-Za-z]{3} [0-9]{4}'
                THEN TO_DATE(FROM_UNIXTIME(UNIX_TIMESTAMP(REGEXP_EXTRACT(clean_session_date, '([0-9]{1,2} [A-Za-z]{3} [0-9]{4})', 1), 'd MMM yyyy')))

            WHEN clean_session_date RLIKE '[0-9]{1,2} [A-Za-z]{3} [0-9]{2}'
                THEN TO_DATE(FROM_UNIXTIME(UNIX_TIMESTAMP(REGEXP_EXTRACT(clean_session_date, '([0-9]{1,2} [A-Za-z]{3} [0-9]{2})', 1), 'd MMM yy')))

            WHEN clean_session_date RLIKE '[0-9]{1,2} [A-Za-z]+ [0-9]{4}'
                THEN TO_DATE(FROM_UNIXTIME(UNIX_TIMESTAMP(REGEXP_EXTRACT(clean_session_date, '([0-9]{1,2} [A-Za-z]+ [0-9]{4})', 1), 'd MMMM yyyy')))

            WHEN clean_session_date RLIKE '[0-9]{1,2} [A-Za-z]+ [0-9]{2}'
                THEN TO_DATE(FROM_UNIXTIME(UNIX_TIMESTAMP(REGEXP_EXTRACT(clean_session_date, '([0-9]{1,2} [A-Za-z]+ [0-9]{2})', 1), 'd MMMM yy')))

            WHEN clean_session_date RLIKE '[A-Za-z]{3} [0-9]{1,2} [0-9]{4}'
                THEN TO_DATE(FROM_UNIXTIME(UNIX_TIMESTAMP(REGEXP_EXTRACT(clean_session_date, '([A-Za-z]{3} [0-9]{1,2} [0-9]{4})', 1), 'MMM d yyyy')))

            WHEN clean_session_date RLIKE '[A-Za-z]+ [0-9]{1,2} [0-9]{4}'
                THEN TO_DATE(FROM_UNIXTIME(UNIX_TIMESTAMP(REGEXP_EXTRACT(clean_session_date, '([A-Za-z]+ [0-9]{1,2} [0-9]{4})', 1), 'MMMM d yyyy')))

            ELSE NULL
        END AS v2_fallback_parsed_date

    FROM cleaned
)

SELECT
    activity_header_id,
    group_id,
    group_desc,
    raw_session_date,
    clean_session_date,

    COALESCE(v1_parsed_date, v2_fallback_parsed_date) AS parsed_form_ans_date

FROM parsed;







%%sql

SELECT
    COUNT(*) AS total_rows,
    COUNT(parsed_form_ans_date) AS parsed_rows,
    COUNT(*) - COUNT(parsed_form_ans_date) AS not_parsed_rows
FROM temp_wip_form_answer_parsed_date_lookup;





%%sql

SELECT
    raw_session_date,
    clean_session_date,
    COUNT(*) AS row_count
FROM temp_wip_form_answer_parsed_date_lookup
WHERE parsed_form_ans_date IS NULL
GROUP BY
    raw_session_date,
    clean_session_date
ORDER BY row_count DESC
LIMIT 100;




%%sql

SELECT
    raw_session_date,
    clean_session_date,
    parsed_form_ans_date
FROM temp_wip_form_answer_parsed_date_lookup
WHERE raw_session_date IN (
    '03/12/2021',
    '30/04/2022',
    '25/11/2022',
    '01.08.2205',
    'see 17/3/22'
)
LIMIT 100;