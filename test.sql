SELECT
    'SEL' AS source_table,
    code,
    question_heading
FROM silver_rdm_sel_read_codes
WHERE LOWER(TRIM(code)) = 'ua0tb'

UNION ALL

SELECT
    'DERM' AS source_table,
    code,
    question_heading
FROM silver_rdm_derm_read_codes
WHERE LOWER(TRIM(code)) = 'ua0tb';