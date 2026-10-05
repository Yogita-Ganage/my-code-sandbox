SELECT *
FROM bronze_sone_srcode
WHERE id_organisation_source = '0D01Z'
LIMIT 20;

SELECT *
FROM bronze_sone_srcode
WHERE TRIM(LOWER(CTV3Code)) = 'uadotb';

SELECT COUNT(DISTINCT TRIM(CTV3Code)) AS distinct_ctv3_codes
FROM bronze_sone_srcode;

SELECT DISTINCT TRIM(CTV3Code) AS ctv3_code
FROM bronze_sone_srcode
WHERE LOWER(TRIM(CTV3Code)) LIKE 'ua%tb'
ORDER BY ctv3_code;

SELECT DISTINCT TRIM(CTV3Code) AS ctv3_code
FROM bronze_sone_srcode
WHERE id_organisation_source = '0D01Z'
  AND LOWER(TRIM(CTV3Code)) LIKE 'ua%tb'
ORDER BY ctv3_code;