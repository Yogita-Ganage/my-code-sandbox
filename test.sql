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
    ) AS actual_del_meth_src_name
FROM silver_sone_srappointment
WHERE id = 15889670415;