MAX(
    CASE
        WHEN LOWER(TRIM(ws.description)) IN (
            'case raised in error',
            'raised in error',
            'bnssg - case raised in error',
            'bnssg- case raised in error'
        )
        THEN 1
        ELSE 0
    END
) AS has_case_raised_in_error