For S1, the form_ans_care_epi_id blanks were caused by silver_sone_srcode.id_referral_in being NULL. The source had 88,152 such rows, which exactly matched the blank Care Episode ID count.
As id_referral_in is required to build form_ans_care_epi_id and no alternative source is available, added:
WHERE sc.id_referral_in IS NOT NULL

Validation confirmed that exactly 88,152 rows were excluded and form_ans_care_epi_id null count is now 0.