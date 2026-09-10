AHRD.customer_id = 167197
        ↓
silver_wip_businessrole.id = 167197
        ↓
business_actor_id = 163010
        ↓
silver_wip_organisation.id = 163010



I checked the failed WIP session UAT issue. The examples from UAT were not showing now, but when I checked all WIP sessions, I found 82 duplicate source session IDs.

I traced one example and found the duplication is coming from the organisation/contract join using only the name. We’ve now found the correct relationship using the customer ID and business role.

Next I’ll update and validate the join, check that the duplicates are removed, and then confirm the approach with Sean. If all looks good, I should be able to finish the task today.