SELECT
    appointment_id,
    COUNT(*) AS total_rows,
    SUM(CASE WHEN is_billed = true THEN 1 ELSE 0 END) AS billed_rows,
    SUM(CASE WHEN billed_fee_amount IS NOT NULL THEN 1 ELSE 0 END) AS non_null_fee_rows
FROM silver_drj_appointment_financials
WHERE appointment_id IS NOT NULL
GROUP BY appointment_id
HAVING COUNT(*) > 1
ORDER BY billed_rows DESC, total_rows DESC;


SELECT
    appointment_id,
    COUNT(*) AS total_rows,
    SUM(CASE WHEN is_billed = true THEN 1 ELSE 0 END) AS billed_rows,
    SUM(CASE WHEN billed_fee_amount IS NOT NULL THEN 1 ELSE 0 END) AS non_null_fee_rows
FROM silver_drj_appointment_financials
WHERE appointment_id IS NOT NULL
GROUP BY appointment_id
HAVING COUNT(*) > 1
   AND (
       SUM(CASE WHEN is_billed = true THEN 1 ELSE 0 END) <> 1
       OR
       SUM(CASE WHEN billed_fee_amount IS NOT NULL THEN 1 ELSE 0 END) <> 1
   );