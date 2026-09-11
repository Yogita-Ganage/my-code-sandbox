-- Get the exact organisation linked to the session customer
LEFT JOIN silver_wip_businessrole AS cust_br
    ON cust_br.id = AHRD.customer_id

LEFT JOIN silver_wip_organisation AS org
    ON org.id = cust_br.business_actor_id