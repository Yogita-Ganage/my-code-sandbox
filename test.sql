Hi Eve, I investigated the remaining blanks further. The issue seems to be at the join between silver_drj_assessment_result_for_answers and silver_drj_assessment_results.  
assessment_result_for_answers.assessment_result_id is referencing IDs for which there is no matching assessment_results.id record. Because of that, ar.user_id and ar.assessment_id are null, which then causes both form_ans_care_epi_id and form_ans_form_ques_id to be null.  
The current Form Answer logic works correctly where the parent assessment result exists. Could you please check a few of the missing assessment_result_id values in legacy/source to confirm whether those parent records exist there?


Hi Sean, I rebuilt the related Bronze and Silver assessment tables and reran the Form Answer logic. The null count reduced from 60,299 to 39,992.
For the remaining records, the assessment_result_id is present in silver_drj_assessment_result_for_answers, but the matching ID is missing in silver_drj_assessment_results.
Because of that join mismatch, user_id and assessment_id are null, so form_ans_care_epi_id and form_ans_form_ques_id are also null.
Where the assessment result exists, the mapping is working correctly. So I just want to confirm whether these unmatched records should be excluded or whether the missing assessment results should exist upstream.”