CASE
    WHEN TO_DATE(
        TO_TIMESTAMP(
            ar.created_at,
            'yyyy-MM-dd''T''HH:mm:ss.SSS''Z'''
        )
    )
    BETWEEN DATE '1899-12-30' AND DATE '9999-12-31'

    THEN FROM_UTC_TIMESTAMP(
        TO_TIMESTAMP(
            ar.created_at,
            'yyyy-MM-dd''T''HH:mm:ss.SSS''Z'''
        ),
        'Europe/London'
    )

    ELSE NULL
END AS form_ans_date_time