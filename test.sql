,CASE
    WHEN sc.id_appointment IS NULL OR sc.id_appointment = -1 THEN -1
    WHEN COUNT(*) OVER (PARTITION BY rdmfq.form_ques_id, CONCAT('SONE', sc.id_appointment)) > 1 THEN 1
    ELSE 0
 END AS form_ans_multi_answer_flag





 ,CASE WHEN COALESCE(asmq.maximum_selection, 1) > 1 THEN 1 ELSE 0 END AS form_ans_multi_answer_flag




 s1--
 S1 form_ans_multi_answer_flag logic updated as per attribute definition.

Source does not provide a direct multi-answer flag, so the flag is now derived using the count of answers for the same form_ques_id and valid session id.

Logic:
1 = part of a multi-answer
0 = not part of a multi-answer
-1 = unknown / cannot determine, used where id_appointment is NULL or -1

Eve confirmed that due to S1 unknown cases, the attribute can be changed from Boolean to numeric/integer format.




mpb--

MPB form_ans_multi_answer_flag logic updated as per attribute definition.

Source does not provide a direct Boolean multi-answer flag, so the flag is derived from the MPB assessment question structure using maximum_selection.

Logic:
1 = maximum_selection > 1, meaning multiple selections are allowed
0 = single answer / single score

Updated MPB to use the same numeric/integer flag format confirmed for S1, so the attribute remains consistent across systems.