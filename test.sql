%%sql

SELECT
    COUNT(*) AS total_lookup_rows,
    COUNT(parsed_form_ans_date) AS parsed_rows,
    SUM(
        CASE
            WHEN parsed_form_ans_date < DATE '1899-12-30'
              OR parsed_form_ans_date > DATE '9999-12-31'
            THEN 1
            ELSE 0
        END
    ) AS outside_range_rows
FROM temp_wip_form_answer_parsed_date_lookup;