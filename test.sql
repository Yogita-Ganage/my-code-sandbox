%%sql

SELECT DISTINCT
    CONCAT('MPB001', ar.user_id) AS form_ans_care_epi_id,
    ar.id AS assessment_result_id,
    ar.created_at AS source_created_at,

    TO_TIMESTAMP(
        ar.created_at,
        'yyyy-MM-dd''T''HH:mm:ss.SSS''Z'''
    ) AS current_parsed_timestamp,

    CASE
        WHEN TO_DATE(
            TO_TIMESTAMP(
                ar.created_at,
                'yyyy-MM-dd''T''HH:mm:ss.SSS''Z'''
            )
        )
        BETWEEN DATE '1899-12-30' AND DATE '9999-12-31'

        THEN TO_TIMESTAMP(
            ar.created_at,
            'yyyy-MM-dd''T''HH:mm:ss.SSS''Z'''
        )

        ELSE NULL
    END AS calculated_form_ans_date_time

FROM silver_drj_assessment_results ar

WHERE CONCAT('MPB001', ar.user_id)
      = 'MPB00100cd2860-3399-4e56-8d2a-8d611ce9264f'

ORDER BY ar.created_at;