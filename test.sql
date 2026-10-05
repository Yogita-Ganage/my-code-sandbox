SELECT *
FROM silver_rdm_form_question
WHERE form_ques_id IN (
    26577, 26578, 26579, 26580,
    26581, 26582, 26583, 26587
);


SELECT *
FROM silver_sone_srcode
WHERE TRIM(LOWER(ctv3_code)) = 'uadotb'
  AND id_organisation_source = '0D01Z';