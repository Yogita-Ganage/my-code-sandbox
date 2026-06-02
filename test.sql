%%sql

SELECT
    activity_header_id,
    group_id,
    group_desc,
    COUNT(*) AS date_row_count,
    COUNT(DISTINCT value_desc) AS distinct_date_value_count,
    CONCAT_WS(' | ', COLLECT_SET(value_desc)) AS date_values
FROM temp_silver_wip_activityheader_statistics
WHERE TRIM(LOWER(type_desc)) IN ('call date', 'session date')
  AND value_desc IS NOT NULL
GROUP BY
    activity_header_id,
    group_id,
    group_desc
HAVING COUNT(DISTINCT value_desc) > 1
ORDER BY distinct_date_value_count DESC, date_row_count DESC
LIMIT 100;



%%sql

SELECT
    activity_header_id,
    group_id,
    group_desc,
    type_id,
    type_desc,
    value_desc,
    COUNT(*) AS duplicate_row_count
FROM temp_silver_wip_activityheader_statistics
WHERE TRIM(LOWER(type_desc)) IN ('call date', 'session date')
  AND value_desc IS NOT NULL
GROUP BY
    activity_header_id,
    group_id,
    group_desc,
    type_id,
    type_desc,
    value_desc
HAVING COUNT(*) > 1
ORDER BY duplicate_row_count DESC
LIMIT 100;



%%sql

SELECT
    COUNT(*) AS total_date_groups,
    SUM(CASE WHEN distinct_date_value_count = 1 THEN 1 ELSE 0 END) AS single_date_groups,
    SUM(CASE WHEN distinct_date_value_count > 1 THEN 1 ELSE 0 END) AS multiple_date_groups
FROM (
    SELECT
        activity_header_id,
        group_id,
        group_desc,
        COUNT(DISTINCT value_desc) AS distinct_date_value_count
    FROM temp_silver_wip_activityheader_statistics
    WHERE TRIM(LOWER(type_desc)) IN ('call date', 'session date')
      AND value_desc IS NOT NULL
    GROUP BY
        activity_header_id,
        group_id,
        group_desc
) x;

--vali---

%%sql

SELECT
    COUNT(*) AS total_rows,
    COUNT(form_ans_date) AS populated_form_ans_date_rows,
    COUNT(*) - COUNT(form_ans_date) AS null_form_ans_date_rows
FROM wiptest_silver_form_answer
WHERE z_src_system_id = 'WIP';


%%sql

SELECT
    form_ans_form_ques_id,
    form_ans_care_epi_id,
    form_ans_src_answer,
    form_ans_date,
    z_src_system_instance,
    z_src_system_id
FROM wiptest_silver_form_answer
WHERE z_src_system_id = 'WIP'
  AND form_ans_date IS NOT NULL
LIMIT 50;


%%sql

SELECT
    form_ans_form_ques_id,
    form_ans_care_epi_id,
    form_ans_src_answer,
    form_ans_date,
    COUNT(*) AS row_count
FROM wiptest_silver_form_answer
WHERE z_src_system_id = 'WIP'
GROUP BY
    form_ans_form_ques_id,
    form_ans_care_epi_id,
    form_ans_src_answer,
    form_ans_date
HAVING COUNT(*) > 1
ORDER BY row_count DESC
LIMIT 50;




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

    FROM test_temp_wip_form_answer_date_lookup
)