Hi Eve, I’m working on MPB logic for care_epi_number. The attribute definition says it should be the short patient number in full, for example 10025127-1, but it does not mention the exact source column.

In silver_drj_users, I can see reference_id = 10025127, and for the same reference_id there are multiple user records. My understanding is that the full care_epi_number should be derived as reference_id plus an episode sequence suffix, for example reference_id + '-' + row number by created_at, giving 10025127-1, 10025127-2, etc.

Can you please confirm if this is the correct logic for MPB, or if there is another source column/table that already holds the full short patient number?