%%sql

SELECT DISTINCT
    CONCAT('MPB001', ar.user_id) AS form_ans_care_epi_id,
    ar.created_at AS source_created_at,

    TO_TIMESTAMP(
        ar.created_at,
        'yyyy-MM-dd''T''HH:mm:ss.SSS''Z'''
    ) AS current_timestamp,

    FROM_UTC_TIMESTAMP(
        TO_TIMESTAMP(
            ar.created_at,
            'yyyy-MM-dd''T''HH:mm:ss.SSS''Z'''
        ),
        'Europe/London'
    ) AS uk_local_timestamp

FROM silver_drj_assessment_results ar

WHERE CONCAT('MPB001', ar.user_id)
      = '<तू आत्ता वापरलेला exact UAT CARE EPI ID>'

ORDER BY source_created_at;