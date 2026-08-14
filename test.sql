%%sql

SELECT
    ar.created_at AS source_created_at,

    TO_TIMESTAMP(
        ar.created_at,
        'yyyy-MM-dd''T''HH:mm:ss.SSS''Z'''
    ) AS current_parsed_timestamp,

    y.form_ans_date_time AS current_form_ans_date_time

FROM silver_form_answer_ytest y

LEFT JOIN silver_drj_assessment_result_for_answers arans
    ON y.form_ans_id = CONCAT('MPB001', arans.id)

LEFT JOIN silver_drj_assessment_results ar
    ON arans.assessment_result_id = ar.id

WHERE y.form_ans_id = 'MPB00100bfce1fc-eb6f-4734-8d73-70513df112ef';