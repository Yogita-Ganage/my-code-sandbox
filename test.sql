%%sql

SELECT *
FROM silver_rdm_care_product
WHERE cprod_id IN (
    4705, 7952,
    4726, 7994,
    4966, 8279,
    5116, 8936,
    5135, 8976,
    5158, 9019,
    5247, 9260
)
ORDER BY LOWER(TRIM(cprod_src_id)), cprod_id;