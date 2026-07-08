Investigation:
UAT failed for SONE form_ques_src_name_full because the add logic was returning only the question name from form_ans_bridge_form_ques_src_name. As per the updated attribute definition, SONE values should be sourced from silver_rdm_form_answer_bridging and form_ques_src_name_full should be built using the tab plus question name.

Change made:
Updated the SONE source logic in Create RDM Sharepoint List Additions. form_ques_src_name_full and form_ques_src_name_short now use a concat of form_ans_bridge_form_ques_src_tab and form_ans_bridge_form_ques_src_name.

Previous logic:
form_ans_bridge_form_ques_src_name

Updated logic:
form_ans_bridge_form_ques_src_tab + '_' + form_ans_bridge_form_ques_src_name

Validation:
Checked source data for SONE and confirmed there are 709 valid rows, with 0 null tab rows, 0 blank tab rows, and 0 null question rows. Also validated the failed UAT sample records:
- SONEOOD1Z_250 now returns Patient Triaging_Additional Notes
- SONEOOD1Z_275 now returns Patient Triaging_Additional Notes
- SONEOOD1Z_280 now returns MCATS Virtual Triage & Letters_Treatment Plan:

Note:
Initial implementation followed the previous SONE definition, which used only form_ans_bridge_ques_src_name per source system instance. The definition has since been updated to require tab + question name, so the SONE logic has been revised accordingly.