SELECT DISTINCT
    appt.appointment_type_id,
    appttype.name AS appointment_type_name,
    CONCAT('MPB001_', CAST(appttype.id AS STRING)) AS expected_del_meth_src_id,
    rdm.del_meth_src_id,
    rdm.del_meth_id,
    rdm.del_meth_src_name,
    rdm.del_meth_name_conformed
FROM silver_drj_appointments appt
LEFT JOIN silver_drj_appointment_types appttype
    ON appttype.id = appt.appointment_type_id
LEFT JOIN silver_rdm_delivery_method rdm
    ON LOWER(TRIM(rdm.del_meth_src_id))
       = LOWER(TRIM(CONCAT('MPB001_', CAST(appttype.id AS STRING))))
WHERE appttype.id IS NOT NULL
ORDER BY appt.appointment_type_id;