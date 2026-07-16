,CASE
    WHEN TO_DATE(ar.created_at)
         BETWEEN DATE '1899-12-30' AND DATE '9999-12-31'
    THEN TO_DATE(ar.created_at)
    ELSE CAST(NULL AS DATE)
END AS form_ans_date


%%sql

SELECT
    COUNT(*) AS total_rows,
    COUNT(form_ans_date) AS populated_dates,
    SUM(
        CASE
            WHEN form_ans_date < DATE '1899-12-30'
              OR form_ans_date > DATE '9999-12-31'
            THEN 1
            ELSE 0
        END
    ) AS outside_range_dates
FROM silver_form_answer_y;



%%sql

SELECT
    form_ans_care_epi_id,
    form_ans_date,
    form_ans_date_time
FROM silver_form_answer_y
WHERE form_ans_date IS NULL;