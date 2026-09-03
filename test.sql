SELECT
    SerT.id AS service_type_id,
    srv.id AS service_id,
    atyp.id AS activity_type_id,
    COUNT(*) AS record_count
FROM silver_wip_activityentry ae

LEFT JOIN silver_wip_activityheader AH
    ON ae.activity_header_id = AH.id

LEFT JOIN silver_wip_ServiceType SerT
    ON SerT.id = AH.service_type_id

LEFT JOIN silver_wip_activitytype atyp
    ON ae.activity_type_id = atyp.id

LEFT JOIN silver_wip_activityservice actserv
    ON actserv.id = ae.activity_service_id

LEFT JOIN silver_wip_service srv
    ON actserv.service_id = srv.id

WHERE SerT.id IS NULL
   OR srv.id IS NULL
   OR atyp.id IS NULL

GROUP BY
    SerT.id,
    srv.id,
    atyp.id;




SELECT
    del_meth_src_id,
    COUNT(*) AS cnt
FROM silver_rdm_delivery_method
WHERE del_meth_src_id LIKE 'WIP001_%'
GROUP BY del_meth_src_id
HAVING COUNT(*) > 1
ORDER BY cnt DESC;
m
h