SELECT
    COUNT(*) AS total_rows,
    COUNT(form_ans_date) AS populated_dates,
    COUNT(*) - COUNT(form_ans_date) AS null_dates
FROM silver_form_answer_y;




Updated MPB Form Answer Date as per the revised definition. Added date range validation so values outside 30/12/1899 to 31/12/9999 return NULL. Validated the updated output table and confirmed outside_range_dates = 0.