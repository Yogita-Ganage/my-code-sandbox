-- Exclude answer rows where no matching assessment result exists, as Form Question ID is mandatory
WHERE ar.id IS NOT NULL

Rebuilt the related MPB Bronze and Silver assessment tables and reran the Form Answer logic. The form_ans_care_epi_id null count reduced from 60,299 to 39,992.
Further investigation showed that these remaining rows have assessment_result_id values in silver_drj_assessment_result_for_answers, but no matching record in silver_drj_assessment_results. Because of this, form_ans_care_epi_id and form_ans_form_ques_id were null.
Sean confirmed that these unmatched rows can be excluded, as form_ans_form_ques_id is a mandatory field. Added WHERE ar.id IS NOT NULL to exclude them.
Validation confirmed that exactly 39,992 rows were excluded, and both form_ans_care_epi_id and form_ans_form_ques_id now have 0 nulls. Sample missing IDs were also shared with Sean for further source/legacy investigation.