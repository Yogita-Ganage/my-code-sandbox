SELECT
    ctv3_code,
    ctv3_text,
    id_organisation_source,
    id_referral_in
FROM silver_sone_srcode
WHERE LOWER(TRIM(ctv3_code)) = 'ua0tb'
  AND LOWER(TRIM(id_organisation_source)) = 'o0d1z';



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