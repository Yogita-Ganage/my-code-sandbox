SELECT DISTINCT
    st.id AS service_type_id,
    s.id AS service_id,
    at.id AS activity_type_id,

    CONCAT(
        'WIP001_',
        CAST(st.id AS STRING),
        '_',
        CAST(s.id AS STRING),
        '_',
        CAST(at.id AS STRING)
    ) AS expected_del_meth_src_id,

    rdm.del_meth_src_id,
    rdm.del_meth_id,
    rdm.del_meth_src_name,
    rdm.del_meth_name_conformed

FROM silver_wip_activityentry ae

LEFT JOIN silver_wip_activityheader ah
    ON ae.activity_header_id = ah.id

LEFT JOIN silver_wip_servicetype st
    ON ah.service_type_id = st.id

LEFT JOIN silver_wip_activityservice acs
    ON ae.activity_service_id = acs.id

LEFT JOIN silver_wip_service s
    ON acs.service_id = s.id

LEFT JOIN silver_wip_activitytype at
    ON ae.activity_type_id = at.id

LEFT JOIN silver_rdm_delivery_method rdm
    ON LOWER(TRIM(rdm.del_meth_src_id))
       = LOWER(TRIM(
           CONCAT(
               'WIP001_',
               CAST(st.id AS STRING),
               '_',
               CAST(s.id AS STRING),
               '_',
               CAST(at.id AS STRING)
           )
       ))

WHERE st.id IS NOT NULL
  AND s.id IS NOT NULL
  AND at.id IS NOT NULL

ORDER BY
    st.id,
    s.id,
    at.id;