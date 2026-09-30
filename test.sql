SELECT
    appointment_id,
    COUNT(*) AS financial_rows,
    COUNT(
        DISTINCT COALESCE(
            CAST(billed_fee_amount AS STRING),
            'NULL'
        )
    ) AS distinct_cost_values
FROM silver_drj_appointment_financials
WHERE appointment_id IS NOT NULL
GROUP BY appointment_id
HAVING COUNT(*) > 1
   AND COUNT(
        DISTINCT COALESCE(
            CAST(billed_fee_amount AS STRING),
            'NULL'
        )
   ) > 1;