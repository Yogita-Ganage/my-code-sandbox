-- Keep one financial record per appointment, prioritising non-null billed fee values.
LEFT JOIN (
    SELECT * FROM (
        SELECT af.*, ROW_NUMBER() OVER (PARTITION BY appointment_id ORDER BY CASE WHEN billed_fee_amount IS NOT NULL THEN 0 ELSE 1 END, updated_at DESC) rn
        FROM silver_drj_appointment_financials af
    ) x WHERE rn = 1
) apptfin ON apptfin.appointment_id = appt.id


