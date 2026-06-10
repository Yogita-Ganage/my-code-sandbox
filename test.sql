Updated MPB `form_ans_date_time` logic using `ar.created_at` from `silver_drj_assessment_results`.

The source value is available in UTC datetime format, e.g. `2022-09-01T01:11:29.727Z`.

Implemented `form_ans_date_time` using the full `created_at` timestamp as per the clinical scores definition.

Logic:
`TO_TIMESTAMP(ar.created_at, "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'") AS form_ans_date_time`

Validated MPB output to confirm `form_ans_date_time` is populated with both date and time from the source timestamp.