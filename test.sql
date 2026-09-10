DESCRIBE silver_wip_activityheaderroledetail;



SELECT
    ae.id AS activity_entry_id,
    ah.id AS activity_header_id,
    AHRD.*
FROM silver_wip_activityentry ae
LEFT JOIN silver_wip_activityheader ah
    ON ae.activity_header_id = ah.id
LEFT JOIN silver_wip_activityheaderroledetail AHRD
    ON ah.id = AHRD.activity_header_id
WHERE ae.id = 505044;