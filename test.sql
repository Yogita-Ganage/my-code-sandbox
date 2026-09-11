-- Get the exact organisation linked to the session customer
LEFT JOIN silver_wip_businessrole AS cust_br
    ON cust_br.id = AHRD.customer_id

LEFT JOIN silver_wip_organisation AS org
    ON org.id = cust_br.business_actor_id



SELECT
    ae.id AS session_id,
    ae.activity_service_id,
    actserv.service_id,
    serv.id AS rdm_service_id,
    serv.description,
    serv.service_type
FROM silver_wip_activityentry ae

LEFT JOIN silver_wip_activityservice actserv
    ON actserv.id = ae.activity_service_id

LEFT JOIN silver_rdm_wip_service_type serv
    ON serv.id = actserv.service_id

WHERE ae.id = 326701;