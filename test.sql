# Allows Spark to write old/future source dates without failing.
spark.conf.set("spark.sql.parquet.datetimeRebaseModeInWrite", "CORRECTED")

# Allows Spark to write old timestamp values without failing.
spark.conf.set("spark.sql.parquet.int96RebaseModeInWrite", "CORRECTED")



-- Parses WIP free-text Session Date / Call Date values into form_ans_date.
-- Uses start-match parsing first, with fallback parsing only when the initial parse returns null.
-- -EVE-Retains source future/historic dates for later DQ review rather than nulling them in this mapping




Implemented WIP form_ans_date parsing logic for Session Date / Call Date answers.

Created a temporary parsed date lookup table:

temp_wip_form_answer_parsed_date_lookup

This lookup parses free-text WIP date answers into parsed_form_ans_date. The logic first uses the existing start-of-text date parsing, then applies fallback parsing only when the first parse returns null. This keeps existing valid parsed dates unchanged while also handling valid dates found later in free-text values.
Examples:
10.05.24 (23/07/2024 with Gail) → 2024-05-10
DNA 4/3/25 → 2025-03-04
Added Spark write configuration to allow old/future source dates to be written without the notebook failing.

Validation completed:

total_rows = 228403
parsed_rows = 224979
not_parsed_rows = 3424

Remaining unparsed values are mainly non-date text or partial dates without a year, for example cancellation/review text or values like 29 Nov, 17 Aug, etc. These cannot be reliably parsed without assuming a year.

As confirmed with Eve, future/historic source dates should be retained as parsed values for now. DQ rules will be added later to flag dates that are in the future or before the agreed valid date threshold, so they can be reviewed and corrected at source.




### Date lookup table - WIP

- Creates a WIP date lookup from **Session Date** / **Call Date** answers.
- Keeps only one clear date value per activity/group, so the final join does not create duplicate rows.
- Records with multiple different date values are left out for DQ/source review.