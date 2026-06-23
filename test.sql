-- Check which WIP columns actually contain DNA / Cancel / Booked / Attended style values
SELECT
    ae.id AS activity_entry_id,
    ah.id AS activity_header_id,
    ae.activity_date_time,
    ae.description AS activity_entry_description,
    srv.description AS activity_service_description,
    actyp.description AS activity_type_description,
    st.description AS activity_status_description
FROM silver_wip_activityentry ae
LEFT JOIN silver_wip_activityheader ah
    ON ae.activity_header_id = ah.id
LEFT JOIN silver_wip_activityservice srv
    ON ah.id = srv.activity_header_id
LEFT JOIN silver_wip_activitytype actyp
    ON ah.activity_type_id = actyp.id
LEFT JOIN silver_wip_activitystatus st
    ON ae.activity_status_id = st.id
WHERE LOWER(CONCAT_WS(' ',
        ae.description,
        srv.description,
        actyp.description,
        st.description
    )) LIKE '%dna%'
   OR LOWER(CONCAT_WS(' ',
        ae.description,
        srv.description,
        actyp.description,
        st.description
    )) LIKE '%cancel%'
LIMIT 100;









-- See what status the definition logic would produce
SELECT
    CASE
        WHEN LOWER(CONCAT_WS(' ', ae.description, srv.description, actyp.description, st.description)) LIKE '%dna%'
            THEN 'Did Not Attend'
        WHEN LOWER(CONCAT_WS(' ', ae.description, srv.description, actyp.description, st.description)) LIKE '%cancel%'
            THEN 'Cancelled with greater than 24 hours notice'
        WHEN ae.activity_date_time > current_timestamp()
            THEN 'Booked'
        WHEN ae.activity_date_time <= current_timestamp()
            THEN 'Attended'
        ELSE 'Unknown'
    END AS expected_session_status_src_name,
    COUNT(*) AS row_count
FROM silver_wip_activityentry ae
LEFT JOIN silver_wip_activityheader ah
    ON ae.activity_header_id = ah.id
LEFT JOIN silver_wip_activityservice srv
    ON ah.id = srv.activity_header_id
LEFT JOIN silver_wip_activitytype actyp
    ON ah.activity_type_id = actyp.id
LEFT JOIN silver_wip_activitystatus st
    ON ae.activity_status_id = st.id
GROUP BY
    CASE
        WHEN LOWER(CONCAT_WS(' ', ae.description, srv.description, actyp.description, st.description)) LIKE '%dna%'
            THEN 'Did Not Attend'
        WHEN LOWER(CONCAT_WS(' ', ae.description, srv.description, actyp.description, st.description)) LIKE '%cancel%'
            THEN 'Cancelled with greater than 24 hours notice'
        WHEN ae.activity_date_time > current_timestamp()
            THEN 'Booked'
        WHEN ae.activity_date_time <= current_timestamp()
            THEN 'Attended'
        ELSE 'Unknown'
    END
ORDER BY row_count DESC;