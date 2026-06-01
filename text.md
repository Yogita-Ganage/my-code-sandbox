Hi Eve,

I’m reviewing the MPB mapping for `form_ans_date` in `silver_form_answer`.

The definitions provided seem to relate to the second MPB block only, which is the assessment / clinical scores block using `drj_assessmentresults`. For that block, `form_ans_date` is defined as the date extracted from `drj_assessmentresults.created_at`.

However, there is also a first MPB block for epicrisis / anamnesis answers. I cannot see a definition for `form_ans_date` for this first block.

Could you please confirm what we should use for `form_ans_date` in the first MPB epicrisis / anamnesis block?

Currently it is using `TO_DATE(an.created_at)` from `silver_drj_anamnesises`. Should we keep this, or should `form_ans_date` be left null for this block?

I don’t think we should join `drj_assessmentresults` into the first block just to populate `form_ans_date`, unless there is a confirmed relationship between those records.