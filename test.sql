Updated MPB assessment answer logic for form_ans_form_ques_id.

The existing source-based value was replaced with the RDM Form Question primary key. 
Joined silver_form_answer MPB assessment results to silver_rdm_form_question using the same source ID logic created in the RDM add table: MPB001_<assessment_id>.

Validation completed:
- assessment_results.assessment_id successfully maps to silver_drj_assessments.id
- form_ques_src_id is unique in silver_rdm_form_question
- RDM join returns expected form_ques_id values
- Repeated form_ans_form_ques_id values are expected because multiple answers can link to the same form question