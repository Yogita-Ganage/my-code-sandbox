wip_source AS (
    SELECT DISTINCT
        CONCAT(
            'WIP001_', 
            st.id, '_',
            s.id, '_',
            at.id
        ) AS del_meth_src_id,

        'WIP001' AS del_meth_src_sys_inst_id,

        CONCAT_WS(
            '_',
            st.description,
            s.description,
            at.description
        ) AS del_meth_src_name

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

    WHERE at.id IS NOT NULL
)