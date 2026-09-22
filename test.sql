SELECT
    COUNT(*) AS total_appointments,
    SUM(CASE WHEN follow_up_appointment = true THEN 1 ELSE 0 END) AS follow_up_true,
    SUM(CASE WHEN telephone_appointment = true THEN 1 ELSE 0 END) AS telephone_true,
    SUM(CASE WHEN rota_type IS NULL OR TRIM(rota_type) = '' THEN 1 ELSE 0 END) AS rota_type_missing
FROM silver_sone_srappointment;




SELECT
    id AS appointment_id,
    rota_type,
    follow_up_appointment,
    telephone_appointment,
    CONCAT_WS(
        '_',
        NULLIF(TRIM(rota_type), ''),
        CASE WHEN follow_up_appointment = true THEN 'Follow-up Appointment' END,
        CASE WHEN telephone_appointment = true THEN 'Telephone Appointment' END
    ) AS expected_del_meth_src_name
FROM silver_sone_srappointment
WHERE rota_type IS NOT NULL
  AND (
      follow_up_appointment = true
      OR telephone_appointment = true
  )
LIMIT 100;