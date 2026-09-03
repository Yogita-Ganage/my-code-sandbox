WITH affected AS (
    SELECT DISTINCT
        ae.id AS activity_entry_id,
        ae.activity_header_id,
        ae.activity_service_id,
        ae.activity_type_id
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

    WHERE st.id IS NULL
      AND s.id IS NOT NULL
      AND at.id IS NOT NULL
)

SELECT
    a.activity_entry_id,
    a.activity_header_id,

    sah.id AS silver_header_id,
    sah.file_number AS silver_case_number,
    sah.service_type_id AS silver_service_type_id,

    bah.Id AS bronze_header_id,
    bah.FileNumber AS bronze_case_number

FROM affected a

LEFT JOIN silver_wip_activityheader sah
    ON a.activity_header_id = sah.id

LEFT JOIN bronze_wip_activityheader bah
    ON a.activity_header_id = bah.Id

ORDER BY a.activity_entry_id;