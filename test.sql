-- Get the exact organisation linked to the session customer
LEFT JOIN silver_wip_businessrole AS cust_br
    ON cust_br.id = AHRD.customer_id

LEFT JOIN silver_wip_organisation AS org
    ON org.id = cust_br.business_actor_id



Traced one duplicate example and found that the organisation was being joined using customer_name only. As the same organisation name can exist against multiple organisation IDs, this was creating additional session rows.
Identified the correct source relationship as: AHRD.customer_id → silver_wip_businessrole.id → business_actor_id → silver_wip_organisation.id.
Compared three join approaches. The existing name-only join created 30 extra rows and had 15 unmatched sessions. The ID-only join returned 0 extra rows and 0 unmatched sessions, while ID + name resulted in 18 unmatched sessions.
Updated the organisation join to use the ID-based relationship in a test Sessions table. After the change, duplicate src_session_id count reduced from 82 to 52.
The remaining 52 duplicates are still being investigated to identify any additional join causing row duplication.

Next step: trace one of the remaining duplicate sessions and validate the other WIP joins before finalising the code change.