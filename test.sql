,CASE
    WHEN s.group_desc IN ('CYP Triage Assessment Presenting Issues', 'Presenting Issues')
         AND COUNT(*) OVER (PARTITION BY s.activity_header_id, s.group_id, s.type_id) > 1
    THEN 1
    ELSE 0
 END AS form_ans_multi_answer_flag



 WIP form_ans_multi_answer_flag logic updated as per attribute definition.

For WIP, multi-answer is applicable to presenting issue answer groups only. The logic checks CYP Triage Assessment Presenting Issues and Presenting Issues; if the count of answers for the same activity_header_id, group_id, and type_id is greater than 1, the flag is set to 1, otherwise 0.

Validation showed both single-answer and multi-answer records, and sample checks confirmed multiple selected presenting issue answers within the same activity/group/type.