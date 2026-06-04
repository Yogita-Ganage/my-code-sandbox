Updated S1/SONE `form_ans_time_id` logic using `sc.date_event_recorded` from `silver_sone_srcode`.

The source value is available as a string datetime, e.g. `31 Jan 2024 21:24:03`.

Implemented `form_ans_time_id` by extracting only the time component from `date_event_recorded` and casting it back to timestamp for TimeDim/time_id alignment.

Note: Since `form_ans_time_id` is cast back to timestamp after extracting only the time component, Spark adds the default epoch date (`1970-01-01`) with the correct source time value.