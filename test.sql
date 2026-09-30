SELECT
    appointment_id,
    COUNT(*) AS cnt
FROM silver_drj_appointment_financials
GROUP BY appointment_id
HAVING COUNT(*) > 1
ORDER BY cnt DESC;


SELECT
    id,
    appointment_id,
    billed_fee_amount,
    created_at,
    updated_at,
    billed_at
FROM silver_drj_appointment_financials
WHERE appointment_id = 130789
ORDER BY updated_at DESC;