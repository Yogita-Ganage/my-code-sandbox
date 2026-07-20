CASE WHEN TO_DATE(TO_TIMESTAMP(sc.date_event_recorded,'dd MMM yyyy HH:mm:ss'))
          BETWEEN DATE '1899-12-30' AND DATE '9999-12-31'
     THEN TO_TIMESTAMP(sc.date_event_recorded,'dd MMM yyyy HH:mm:ss')
     ELSE NULL
END AS form_ans_date_time



Updated form_ans_date_time logic for MPB as per the revised definition. Values outside the date range 30/12/1899 to 31/12/9999 will now return NULL.