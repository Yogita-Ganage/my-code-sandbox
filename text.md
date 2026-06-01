Updated SONE/S1 mapping for form_ans_date in silver_form_answer.

Mapped form_ans_date as per the Clinical Scores definition by extracting the date from SRCode.DateEventRecorded.

Implemented logic using date_event_recorded from silver_sone_srcode and converted the source string timestamp into a DATE value.

Validation completed:

Notebook ran successfully.
form_ans_date is now populated for SONE records.
Spot check confirms values are appearing correctly in date format, e.g. 2023-10-06, 2024-01-23, 2024-06-11.