SELECT
    COUNT(*) AS outside_range_dates
FROM silver_form_answer
WHERE form_ans_date < DATE '1899-12-30'
   OR form_ans_date > DATE '9999-12-31';