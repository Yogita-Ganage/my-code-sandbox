,CASE
    WHEN COALESCE(asmq.maximum_selection, 1) > 1 THEN True
    ELSE False
END AS form_ans_multi_answer_flag




For MPB, `form_ans_multi_answer_flag` has been derived from the assessment question structure instead of hardcoding the value. The source does not provide a direct flag, so `maximum_selection > 1` is used to identify questions that allow multiple selections. Validation showed both single-answer and multi-selection records in MPB, so the flag is now populated as True/False based on this rule.