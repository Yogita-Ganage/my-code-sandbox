SELECT
    st.description,
    LOWER(TRIM(st.description)) AS cleaned_status,
    COUNT(*) AS row_count
FROM silver_wip_activityentry ae
LEFT JOIN silver_wip_activitystatus st
    ON ae.activity_status_id = st.id
WHERE LOWER(TRIM(st.description)) LIKE '%error%'
   OR LOWER(TRIM(st.description)) LIKE '%raised%'
   OR LOWER(TRIM(st.description)) LIKE '%cancel%'
   OR LOWER(TRIM(st.description)) LIKE '%fail%'
GROUP BY
    st.description,
    LOWER(TRIM(st.description))
ORDER BY st.description;