CASE
    WHEN TO_DATE(
             TO_TIMESTAMP(sc.date_event_recorded, 'dd MMM yyyy HH:mm:ss')
         ) BETWEEN DATE '1899-12-30' AND DATE '9999-12-31'
    THEN TO_DATE(
             TO_TIMESTAMP(sc.date_event_recorded, 'dd MMM yyyy HH:mm:ss')
         )
    ELSE NULL
END AS form_ans_date




SELECT
    COUNT(*) AS outside_range_dates
FROM silver_form_answer
WHERE z_src_system_id = 'SONE'
  AND (
        form_ans_date < DATE '1899-12-30'
        OR form_ans_date > DATE '9999-12-31'
      );