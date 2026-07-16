%%sql

WITH parsed AS (
    SELECT
        sc.id,
        sc.date_event_recorded,
        TO_DATE(
            TO_TIMESTAMP(sc.date_event_recorded, 'dd MMM yyyy HH:mm:ss')
        ) AS parsed_form_ans_date
    FROM silver_some_srcode sc
)

SELECT
    COUNT(*) AS total_rows,
    COUNT(parsed_form_ans_date) AS parsed_rows,
    SUM(
        CASE
            WHEN parsed_form_ans_date < DATE '1899-12-30'
              OR parsed_form_ans_date > DATE '9999-12-31'
            THEN 1
            ELSE 0
        END
    ) AS outside_range_rows
FROM parsed;