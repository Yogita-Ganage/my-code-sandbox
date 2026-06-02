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
                THEN TO_DATE(FROM_UNIXTIME(UNIX_TIMESTAMP(dl.raw_session_date, 'd/M/yy')))

            WHEN dl.raw_session_date RLIKE '^[0-9]{1,2}/[0-9]{1,2}/[0-9]{4}$'
                THEN TO_DATE(FROM_UNIXTIME(UNIX_TIMESTAMP(dl.raw_session_date, 'd/M/yyyy')))

            WHEN dl.raw_session_date RLIKE '^[0-9]{1,2}\\.[0-9]{1,2}\\.[0-9]{2}$'
                THEN TO_DATE(FROM_UNIXTIME(UNIX_TIMESTAMP(dl.raw_session_date, 'd.M.yy')))

            WHEN dl.raw_session_date RLIKE '^[0-9]{1,2}\\.[0-9]{1,2}\\.[0-9]{4}$'
                THEN TO_DATE(FROM_UNIXTIME(UNIX_TIMESTAMP(dl.raw_session_date, 'd.M.yyyy')))

            WHEN dl.raw_session_date RLIKE '^[0-9]{1,2}-[0-9]{1,2}-[0-9]{2}$'
                THEN TO_DATE(FROM_UNIXTIME(UNIX_TIMESTAMP(dl.raw_session_date, 'd-M-yy')))

            WHEN dl.raw_session_date RLIKE '^[0-9]{1,2}-[0-9]{1,2}-[0-9]{4}$'
                THEN TO_DATE(FROM_UNIXTIME(UNIX_TIMESTAMP(dl.raw_session_date, 'd-M-yyyy')))

            WHEN dl.raw_session_date RLIKE '^[0-9]{1,2}(st|nd|rd|th)? [A-Za-z]{3} [0-9]{4}$'
                THEN TO_DATE(
                    FROM_UNIXTIME(
                        UNIX_TIMESTAMP(
                            REGEXP_REPLACE(dl.raw_session_date, '(st|nd|rd|th)', ''),
                            'd MMM yyyy'
                        )
                    )
                )

            WHEN dl.raw_session_date RLIKE '^[0-9]{1,2}(st|nd|rd|th)? [A-Za-z]+ [0-9]{4}$'
                THEN TO_DATE(
                    FROM_UNIXTIME(
                        UNIX_TIMESTAMP(
                            REGEXP_REPLACE(dl.raw_session_date, '(st|nd|rd|th)', ''),
                            'd MMMM yyyy'
                        )
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
    raw_session_date,
    COUNT(*) AS row_count
FROM joined_rows
WHERE raw_session_date IS NOT NULL
  AND expected_form_ans_date IS NULL
GROUP BY raw_session_date
ORDER BY row_count DESC
LIMIT 50;