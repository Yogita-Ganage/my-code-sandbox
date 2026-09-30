SELECT
    id,
    appointment_id,
    is_billed,
    is_charged,
    invoice_status,
    billed_fee_id,
    billed_fee_amount,
    billed_therapy_type_id,
    charged_fee_id,
    charged_fee_amount,
    charged_therapy_type_id,
    billed_at,
    charged_at,
    created_at,
    updated_at
FROM silver_drj_appointment_financials
WHERE appointment_id = 130789
ORDER BY updated_at DESC;