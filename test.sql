SELECT
  sc.date_event_recorded,
  to_timestamp(sc.date_event_recorded, 'dd MMM yyyy HH:mm:ss') AS form_ans_time_id
FROM silver_sone_srcode sc
LIMIT 20;

to_timestamp(sc.date_event_recorded, 'dd MMM yyyy HH:mm:ss') AS form_ans_time_id,




-- form_ans_time_id currently stores timestamp value from SRCode DateEventRecorded; name may be revised later
to_timestamp(sc.date_event_recorded, 'dd MMM yyyy HH:mm:ss') AS form_ans_time_id,