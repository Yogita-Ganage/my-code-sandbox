test


-- Extract only the time component from created_at and cast it back to TIMESTAMP for TimeDim/time_id alignment.
,TO_TIMESTAMP(DATE_FORMAT(TO_TIMESTAMP(ar.created_at, "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"), 'HH:mm:ss'), 'HH:mm:ss') AS form_ans_time_id





Updated MPB form answer datetime mapping as per the clinical scores definition.

Source column `ar.created_at` from `silver_drj_assessment_results` is available in UTC timestamp format, e.g. `2022-09-01T01:11:29.727Z`.

Implemented:
- `form_ans_time_id`: extracted only the time component from `created_at` and cast it back to timestamp for TimeDim/time_id alignment.
- `form_ans_date_time`: populated using full `created_at` timestamp.
- `form_ans_date`: extracted date from `created_at`.

Validated the output for MPB records to confirm date, datetime, and time_id fields are populated as expected.