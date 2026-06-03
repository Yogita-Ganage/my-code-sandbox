%%sql

WITH cleaned AS (
    SELECT
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
        raw_session_date,
        clean_session_date,

        CASE
            WHEN clean_session_date RLIKE '^[0-9]{1,2}/[0-9]{1,2}/[0-9]{4}.*$'
                THEN TO_DATE(FROM_UNIXTIME(UNIX_TIMESTAMP(REGEXP_EXTRACT(clean_session_date, '^([0-9]{1,2}/[0-9]{1,2}/[0-9]{4})', 1), 'd/M/yyyy')))

            WHEN clean_session_date RLIKE '^[0-9]{1,2}/[0-9]{1,2}/[0-9]{2}.*$'
                THEN TO_DATE(FROM_UNIXTIME(UNIX_TIMESTAMP(REGEXP_EXTRACT(clean_session_date, '^([0-9]{1,2}/[0-9]{1,2}/[0-9]{2})', 1), 'd/M/yy')))

            ELSE NULL
        END AS raw_parsed_form_ans_date
    FROM cleaned
)

SELECT
    COUNT(*) AS total_lookup_rows,
    COUNT(raw_parsed_form_ans_date) AS parsed_rows,
    SUM(CASE WHEN raw_parsed_form_ans_date < DATE '1900-01-01' THEN 1 ELSE 0 END) AS ancient_date_rows,
    SUM(CASE WHEN raw_parsed_form_ans_date > ADD_MONTHS(CURRENT_DATE(), 120) THEN 1 ELSE 0 END) AS future_date_rows
FROM parsed;