I checked whether the first MPB epicrisis/anamnesis block can be linked to drj_assessmentresults for the Clinical Scores attributes.

There is no direct one-to-one relationship. The possible join path through appointment assessments creates multiple assessment result matches per anamnesis record. For example, some anamnesis records match over 100 assessment rows, and the joined row count increases from around 567k distinct anamnesis rows to around 7.8m joined rows.

Because of this, I don’t think we should join drj_assessmentresults into the first MPB block just to populate attributes such as form_ans_date.