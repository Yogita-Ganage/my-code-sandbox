CASE WHEN TO_DATE(TO_TIMESTAMP(ar.created_at,'yyyy-MM-dd''T''HH:mm:ss.SSS''Z'''))
          BETWEEN DATE '1899-12-30' AND DATE '9999-12-31'
     THEN TO_TIMESTAMP(ar.created_at,'yyyy-MM-dd''T''HH:mm:ss.SSS''Z''')
     ELSE NULL
END AS form_ans_date_time



Updated form_ans_date_time logic for MPB as per the revised definition. Values outside the date range 30/12/1899 to 31/12/9999 will now return NULL.