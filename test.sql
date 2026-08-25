SELECT DISTINCT
    at.id AS del_meth_src_id,
    at.name AS del_meth_src_name,
    'MPB001' AS z_src_system_instance
FROM silver_drj_appointments a
INNER JOIN silver_drj_appointment_types at
    ON a.appointment_type_id = at.id
WHERE at.id IS NOT NULL