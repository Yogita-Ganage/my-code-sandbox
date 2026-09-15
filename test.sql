Investigation / Resolution Update

Investigated duplicate WIP src_session_id issue. Initial validation found 82 duplicate source session IDs.
First root cause was the organisation join using customer_name only. Replaced it with the ID-based relationship:
AHRD.customer_id → silver_wip_businessrole.id → business_actor_id → silver_wip_organisation.id.
This reduced duplicates from 82 to 52.
Remaining duplicates were traced to the WIP service mapping. The existing join on service ID alone was returning multiple mappings.
Updated the join to also match serv.service_purpose = SerT.description.
After applying both changes in the test table, the duplicate src_session_id validation now returns 0 duplicates.
Known duplicate examples were also revalidated successfully.