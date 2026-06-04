-- time only, but timestamp datatype
,TO_TIMESTAMP(DATE_FORMAT(TO_TIMESTAMP(sc.date_event_recorded, 'dd MMM yyyy HH:mm:ss'), 'HH:mm:ss'), 'HH:mm:ss') AS form_ans_time_id

-- full date + time
,TO_TIMESTAMP(sc.date_event_recorded, 'dd MMM yyyy HH:mm:ss') AS form_ans_date_time