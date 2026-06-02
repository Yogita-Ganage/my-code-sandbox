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

joined_rows AS (
    SELECT
        s.activity_header_id,
        s.group_id,
        s.group_desc,
        s.type_id,
        s.type_desc AS answer_question,
        s.src_answer_desc AS answer_value,
        dl.raw_session_date,

        CASE
            WHEN dl.raw_session_date RLIKE '^[0-9]{1,2}/[0-9]{1,2}/[0-9]{2}$'
                THEN TO_DATE(TO_TIMESTAMP(dl.raw_session_date, 'd/M/yy'))

            WHEN dl.raw_session_date RLIKE '^[0-9]{1,2}/[0-9]{1,2}/[0-9]{4}$'
                THEN TO_DATE(TO_TIMESTAMP(dl.raw_session_date, 'd/M/yyyy'))

            WHEN dl.raw_session_date RLIKE '^[0-9]{1,2}\\.[0-9]{1,2}\\.[0-9]{2}$'
                THEN TO_DATE(TO_TIMESTAMP(dl.raw_session_date, 'd.M.yy'))

            WHEN dl.raw_session_date RLIKE '^[0-9]{1,2}\\.[0-9]{1,2}\\.[0-9]{4}$'
                THEN TO_DATE(TO_TIMESTAMP(dl.raw_session_date, 'd.M.yyyy'))

            WHEN dl.raw_session_date RLIKE '^[0-9]{1,2}(st|nd|rd|th)? [A-Za-z]+ [0-9]{4}$'
                THEN TO_DATE(
                    TO_TIMESTAMP(
                        REGEXP_REPLACE(dl.raw_session_date, '(st|nd|rd|th)', ''),
                        'd MMMM yyyy'
                    )
                )

            ELSE NULL
        END AS expected_form_ans_date

    FROM test_temp_silver_wip_activityheader_statistics s

    LEFT JOIN date_lookup dl
        ON dl.activity_header_id = s.activity_header_id
       AND dl.group_id = s.group_id
       AND TRIM(LOWER(dl.group_desc)) = TRIM(LOWER(s.group_desc))

    WHERE TRIM(LOWER(s.type_desc)) NOT IN ('call date', 'session date')
)

SELECT
    activity_header_id,
    group_id,
    group_desc,
    type_id,
    answer_question,
    answer_value,
    raw_session_date,
    expected_form_ans_date
FROM joined_rows
WHERE raw_session_date IS NOT NULL
LIMIT 100;






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

joined_rows AS (
    SELECT
        s.activity_header_id,
        s.group_id,
        s.group_desc,
        s.type_desc AS answer_question,
        dl.raw_session_date,

        CASE
            WHEN dl.raw_session_date RLIKE '^[0-9]{1,2}/[0-9]{1,2}/[0-9]{2}$'
                THEN TO_DATE(TO_TIMESTAMP(dl.raw_session_date, 'd/M/yy'))

            WHEN dl.raw_session_date RLIKE '^[0-9]{1,2}/[0-9]{1,2}/[0-9]{4}$'
                THEN TO_DATE(TO_TIMESTAMP(dl.raw_session_date, 'd/M/yyyy'))

            WHEN dl.raw_session_date RLIKE '^[0-9]{1,2}\\.[0-9]{1,2}\\.[0-9]{2}$'
                THEN TO_DATE(TO_TIMESTAMP(dl.raw_session_date, 'd.M.yy'))

            WHEN dl.raw_session_date RLIKE '^[0-9]{1,2}\\.[0-9]{1,2}\\.[0-9]{4}$'
                THEN TO_DATE(TO_TIMESTAMP(dl.raw_session_date, 'd.M.yyyy'))

            WHEN dl.raw_session_date RLIKE '^[0-9]{1,2}(st|nd|rd|th)? [A-Za-z]+ [0-9]{4}$'
                THEN TO_DATE(
                    TO_TIMESTAMP(
                        REGEXP_REPLACE(dl.raw_session_date, '(st|nd|rd|th)', ''),
                        'd MMMM yyyy'
                    )
                )

            ELSE NULL
        END AS expected_form_ans_date

    FROM test_temp_silver_wip_activityheader_statistics s

    LEFT JOIN date_lookup dl
        ON dl.activity_header_id = s.activity_header_id
       AND dl.group_id = s.group_id
       AND TRIM(LOWER(dl.group_desc)) = TRIM(LOWER(s.group_desc))

    WHERE TRIM(LOWER(s.type_desc)) NOT IN ('call date', 'session date')
)

SELECT
    COUNT(*) AS total_answer_rows,
    COUNT(raw_session_date) AS matched_raw_session_date_rows,
    COUNT(expected_form_ans_date) AS parsed_form_ans_date_rows,
    COUNT(*) - COUNT(raw_session_date) AS no_session_date_match_rows,
    COUNT(raw_session_date) - COUNT(expected_form_ans_date) AS matched_but_not_parsed_rows
FROM joined_rows;