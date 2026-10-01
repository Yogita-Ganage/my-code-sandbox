Investigation Findings – MPB form_ans_care_epi_id UAT Failure
UAT reported 60,299 blank form_ans_care_epi_id records for MPB.
Investigation confirmed:
- Current logic is CONCAT('MPB001', ar.user_id).
- ar.user_id itself is populated and maps correctly to silver_drj_users.id for the vast majority of records.
- 60,230 rows have no matching parent record in silver_drj_assessment_results for arans.assessment_result_id.
- These relate to 8,446 distinct assessment result IDs, and the same IDs are also not present in bronze_drj_assessmentresults.
- An additional 69 rows are introduced by duplicate id values in silver_drj_assessment_answers.
- This fully reconciles the UAT blank count: 60,230 + 69 = 60,299.
No code change made yet. Expected handling for these missing parent assessment-result records needs to be confirmed before applying a fix.