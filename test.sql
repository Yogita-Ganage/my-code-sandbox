test


-- Extract only the time component from created_at and cast it back to TIMESTAMP for TimeDim/time_id alignment.
,TO_TIMESTAMP(DATE_FORMAT(TO_TIMESTAMP(ar.created_at, "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"), 'HH:mm:ss'), 'HH:mm:ss') AS form_ans_time_id





Updated MPB form answer datetime mapping as per the clinical scores definition.

Updated MPB form answer date/time logic using `ar.created_at` from `silver_drj_assessment_results`.

The source value is available in UTC datetime format, e.g. `2022-09-01T01:11:29.727Z`.

Implemented:
- `form_ans_time_id`: extracts only the time component from `created_at` and casts it back to timestamp for TimeDim/time_id alignment.
- `form_ans_date_time`: uses the full `created_at` timestamp.
- `form_ans_date`: extracts the date part from `created_at`.

Note: Since `form_ans_time_id` is cast back to timestamp after extracting only the time component, Spark adds the default epoch date (`1970-01-01`) with the correct source time value.