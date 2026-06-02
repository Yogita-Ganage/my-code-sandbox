%%sql

DROP TABLE IF EXISTS temp_wip_form_answer_date_lookup;

CREATE TABLE temp_wip_form_answer_date_lookup AS
SELECT
    activity_header_id,
    group_id,
    group_desc,
    MAX(value_desc) AS raw_session_date
FROM temp_silver_wip_activityheader_statistics
WHERE TRIM(LOWER(type_desc)) IN ('call date', 'session date')
  AND value_desc IS NOT NULL
GROUP BY
    activity_header_id,
    group_id,
    group_desc
HAVING COUNT(DISTINCT value_desc) = 1;


---Parsed date lookup table---
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
                        REGEXP_REPLACE(
                            INITCAP(TRIM(raw_session_date)),
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
    FROM temp_wip_form_answer_date_lookup
)

SELECT
    activity_header_id,
    group_id,
    group_desc,
    raw_session_date,
    clean_session_date,

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
    END AS parsed_form_ans_date

FROM cleaned;







