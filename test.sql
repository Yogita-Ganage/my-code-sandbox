%%sql

WITH date_lookup AS (
    SELECT
        activity_header_id,
        group_id,
        group_desc,
        MAX(value_desc) AS raw_session_date
    FROM test_temp_silver_wip_activityheader_statistics
    WHERE TRIM(LOWER(type_desc)) IN ('call date', 'session date')
      AND value_desc IS NOT NULL
    GROUP BY
        activity_header_id,
        group_id,
        group_desc
    HAVING COUNT(DISTINCT value_desc) = 1
),

base_rows AS (
    SELECT
        s.activity_header_id,
        s.group_id,
        s.group_desc,
        s.type_id,
        s.type_desc AS answer_question,
        s.src_answer_desc AS answer_value,
        dl.raw_session_date,

        TRIM(
            REGEXP_REPLACE(
                REGEXP_REPLACE(
                    REGEXP_REPLACE(
                        REGEXP_REPLACE(
                            INITCAP(TRIM(dl.raw_session_date)),
                            '[–—]',
                            '-'
                        ),
                        '^(Monday|Tuesday|Wednesday|Thursday|Friday|Saturday|Sunday)\\s+',
                        ''
                    ),
                    '([0-9]{1,2})(st|nd|rd|th)\\b',
                    '$1'
                ),
                ',',
                ''
            )
        ) AS clean_session_date

    FROM test_temp_silver_wip_activityheader_statistics s

    LEFT JOIN date_lookup dl
        ON dl.activity_header_id = s.activity_header_id
       AND dl.group_id = s.group_id
       AND TRIM(LOWER(dl.group_desc)) = TRIM(LOWER(s.group_desc))

    WHERE TRIM(LOWER(s.type_desc)) NOT IN ('call date', 'session date')
),

parsed_rows AS (
    SELECT
        activity_header_id,
        group_id,
        group_desc,
        type_id,
        answer_question,
        answer_value,
        raw_session_date,
        clean_session_date,

        CASE
            WHEN clean_session_date RLIKE '^[0-9]{1,2}/[0-9]{1,2}/[0-9]{2}.*$'
                THEN REGEXP_EXTRACT(clean_session_date, '^([0-9]{1,2}/[0-9]{1,2}/[0-9]{2})', 1)

            WHEN clean_session_date RLIKE '^[0-9]{1,2}/[0-9]{1,2}/[0-9]{4}.*$'
                THEN REGEXP_EXTRACT(clean_session_date, '^([0-9]{1,2}/[0-9]{1,2}/[0-9]{4})', 1)

            WHEN clean_session_date RLIKE '^[0-9]{1,2}\\.[0-9]{1,2}\\.[0-9]{2}.*$'
                THEN REGEXP_EXTRACT(clean_session_date, '^([0-9]{1,2}\\.[0-9]{1,2}\\.[0-9]{2})', 1)

            WHEN clean_session_date RLIKE '^[0-9]{1,2}\\.[0-9]{1,2}\\.[0-9]{4}.*$'
                THEN REGEXP_EXTRACT(clean_session_date, '^([0-9]{1,2}\\.[0-9]{1,2}\\.[0-9]{4})', 1)

            WHEN clean_session_date RLIKE '^[0-9]{1,2}-[0-9]{1,2}-[0-9]{2}.*$'
                THEN REGEXP_EXTRACT(clean_session_date, '^([0-9]{1,2}-[0-9]{1,2}-[0-9]{2})', 1)

            WHEN clean_session_date RLIKE '^[0-9]{1,2}-[0-9]{1,2}-[0-9]{4}.*$'
                THEN REGEXP_EXTRACT(clean_session_date, '^([0-9]{1,2}-[0-9]{1,2}-[0-9]{4})', 1)

            WHEN clean_session_date RLIKE '^[0-9]{1,2} [A-Za-z]{3} [0-9]{2}.*$'
                THEN REGEXP_EXTRACT(clean_session_date, '^([0-9]{1,2} [A-Za-z]{3} [0-9]{2})', 1)

            WHEN clean_session_date RLIKE '^[0-9]{1,2} [A-Za-z]{3} [0-9]{4}.*$'
                THEN REGEXP_EXTRACT(clean_session_date, '^([0-9]{1,2} [A-Za-z]{3} [0-9]{4})', 1)

            WHEN clean_session_date RLIKE '^[0-9]{1,2} [A-Za-z]+ [0-9]{2}.*$'
                THEN REGEXP_EXTRACT(clean_session_date, '^([0-9]{1,2} [A-Za-z]+ [0-9]{2})', 1)

            WHEN clean_session_date RLIKE '^[0-9]{1,2} [A-Za-z]+ [0-9]{4}.*$'
                THEN REGEXP_EXTRACT(clean_session_date, '^([0-9]{1,2} [A-Za-z]+ [0-9]{4})', 1)

            WHEN clean_session_date RLIKE '^[A-Za-z]{3} [0-9]{1,2} [0-9]{4}.*$'
                THEN REGEXP_EXTRACT(clean_session_date, '^([A-Za-z]{3} [0-9]{1,2} [0-9]{4})', 1)

            WHEN clean_session_date RLIKE '^[A-Za-z]+ [0-9]{1,2} [0-9]{4}.*$'
                THEN REGEXP_EXTRACT(clean_session_date, '^([A-Za-z]+ [0-9]{1,2} [0-9]{4})', 1)

            ELSE NULL
        END AS extracted_date_text,

        CASE
            WHEN clean_session_date RLIKE '^[0-9]{1,2}/[0-9]{1,2}/[0-9]{2}.*$'
                THEN TO_DATE(FROM_UNIXTIME(UNIX_TIMESTAMP(REGEXP_EXTRACT(clean_session_date, '^([0-9]{1,2}/[0-9]{1,2}/[0-9]{2})', 1), 'd/M/yy')))

            WHEN clean_session_date RLIKE '^[0-9]{1,2}/[0-9]{1,2}/[0-9]{4}.*$'
                THEN TO_DATE(FROM_UNIXTIME(UNIX_TIMESTAMP(REGEXP_EXTRACT(clean_session_date, '^([0-9]{1,2}/[0-9]{1,2}/[0-9]{4})', 1), 'd/M/yyyy')))

            WHEN clean_session_date RLIKE '^[0-9]{1,2}\\.[0-9]{1,2}\\.[0-9]{2}.*$'
                THEN TO_DATE(FROM_UNIXTIME(UNIX_TIMESTAMP(REGEXP_EXTRACT(clean_session_date, '^([0-9]{1,2}\\.[0-9]{1,2}\\.[0-9]{2})', 1), 'd.M.yy')))

            WHEN clean_session_date RLIKE '^[0-9]{1,2}\\.[0-9]{1,2}\\.[0-9]{4}.*$'
                THEN TO_DATE(FROM_UNIXTIME(UNIX_TIMESTAMP(REGEXP_EXTRACT(clean_session_date, '^([0-9]{1,2}\\.[0-9]{1,2}\\.[0-9]{4})', 1), 'd.M.yyyy')))

            WHEN clean_session_date RLIKE '^[0-9]{1,2}-[0-9]{1,2}-[0-9]{2}.*$'
                THEN TO_DATE(FROM_UNIXTIME(UNIX_TIMESTAMP(REGEXP_EXTRACT(clean_session_date, '^([0-9]{1,2}-[0-9]{1,2}-[0-9]{2})', 1), 'd-M-yy')))

            WHEN clean_session_date RLIKE '^[0-9]{1,2}-[0-9]{1,2}-[0-9]{4}.*$'
                THEN TO_DATE(FROM_UNIXTIME(UNIX_TIMESTAMP(REGEXP_EXTRACT(clean_session_date, '^([0-9]{1,2}-[0-9]{1,2}-[0-9]{4})', 1), 'd-M-yyyy')))

            WHEN clean_session_date RLIKE '^[0-9]{1,2} [A-Za-z]{3} [0-9]{2}.*$'
                THEN TO_DATE(FROM_UNIXTIME(UNIX_TIMESTAMP(REGEXP_EXTRACT(clean_session_date, '^([0-9]{1,2} [A-Za-z]{3} [0-9]{2})', 1), 'd MMM yy')))

            WHEN clean_session_date RLIKE '^[0-9]{1,2} [A-Za-z]{3} [0-9]{4}.*$'
                THEN TO_DATE(FROM_UNIXTIME(UNIX_TIMESTAMP(REGEXP_EXTRACT(clean_session_date, '^([0-9]{1,2} [A-Za-z]{3} [0-9]{4})', 1), 'd MMM yyyy')))

            WHEN clean_session_date RLIKE '^[0-9]{1,2} [A-Za-z]+ [0-9]{2}.*$'
                THEN TO_DATE(FROM_UNIXTIME(UNIX_TIMESTAMP(REGEXP_EXTRACT(clean_session_date, '^([0-9]{1,2} [A-Za-z]+ [0-9]{2})', 1), 'd MMMM yy')))

            WHEN clean_session_date RLIKE '^[0-9]{1,2} [A-Za-z]+ [0-9]{4}.*$'
                THEN TO_DATE(FROM_UNIXTIME(UNIX_TIMESTAMP(REGEXP_EXTRACT(clean_session_date, '^([0-9]{1,2} [A-Za-z]+ [0-9]{4})', 1), 'd MMMM yyyy')))

            WHEN clean_session_date RLIKE '^[A-Za-z]{3} [0-9]{1,2} [0-9]{4}.*$'
                THEN TO_DATE(FROM_UNIXTIME(UNIX_TIMESTAMP(REGEXP_EXTRACT(clean_session_date, '^([A-Za-z]{3} [0-9]{1,2} [0-9]{4})', 1), 'MMM d yyyy')))

            WHEN clean_session_date RLIKE '^[A-Za-z]+ [0-9]{1,2} [0-9]{4}.*$'
                THEN TO_DATE(FROM_UNIXTIME(UNIX_TIMESTAMP(REGEXP_EXTRACT(clean_session_date, '^([A-Za-z]+ [0-9]{1,2} [0-9]{4})', 1), 'MMMM d yyyy')))

            ELSE NULL
        END AS expected_form_ans_date

    FROM base_rows
)

SELECT
    activity_header_id,
    group_id,
    group_desc,
    type_id,
    answer_question,
    answer_value,
    raw_session_date,
    clean_session_date,
    extracted_date_text,
    expected_form_ans_date
FROM parsed_rows
WHERE raw_session_date IS NOT NULL
LIMIT 200;