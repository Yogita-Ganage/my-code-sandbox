SELECT
  ar.created_at,
  to_timestamp(ar.created_at, "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'") AS form_ans_time_id
FROM silver_drj_assessment_results ar
LIMIT 20;



to_timestamp(ar.created_at, "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'") AS form_ans_time_id,




Added form_ans_time_id for MPB using silver_drj_assessment_results.created_at converted to timestamp format, as confirmed despite the column name containing "id".