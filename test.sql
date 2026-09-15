-- Use the customer business role to map the exact organisation ID and avoid duplicate session records
LEFT JOIN silver_wip_businessrole AS cust_br
    ON cust_br.id = AHRD.customer_id
-- Updated WIP organisation join to use the customer business role and organisation ID instead of organisation name to prevent duplicate session records
LEFT JOIN silver_wip_organisation AS org
    ON org.id = cust_br.business_actor_id

    -- Match WIP service by both service ID and service purpose to avoid multiple service mappings
LEFT JOIN silver_rdm_wip_service_type serv
    ON serv.id = actserv.service_id
   AND serv.service_purpose = SerT.description