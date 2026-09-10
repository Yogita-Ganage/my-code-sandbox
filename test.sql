WIP505044
   ↓
AHRD.customer_id = 167197
   ↓
silver_wip_businessrole
id = 167197
business_actor_id = 163010
   ↓
silver_wip_organisation
id = 163010
name = Ecclesiastical



I checked the failed WIP session UAT issue. The examples from UAT were not showing now, but when I checked all WIP sessions, I found 82 duplicate source session IDs.

I traced one example and found the duplication is coming from the organisation/contract join using only the name. We’ve now found the correct relationship using the customer ID and business role.

Next I’ll update and validate the join, check that the duplicates are removed, and then confirm the approach with Sean. If all looks good, I should be able to finish the task today.



For this session, 163008 is not a wrong organisation record, but it is the wrong match. The session’s customer_id is 167197, and when we follow that through the business role table, it points to organisation 163010. Because the current join is only on the name Ecclesiastical, both 163008 and 163010 are matching. So 163008 is just an extra match caused by the name-only join.



