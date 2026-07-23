Investigation and validation completed for the Contract RDM flow.

The flow had been disabled after the SharePoint configuration changed. Although the Contract Source System Instance ID column configuration was correct, the lookup relationship to the Source System Instance SharePoint list was incorrect. This was corrected with Mali, and the lookup column is now resolving to the expected numeric IDs.

As the lookup configuration was fixed, there was no need to delete and recreate the existing SharePoint list records. After the dataflow was re-run, the SharePoint data and Silver tables aligned correctly.

I then validated the Contract ADD logic using two approaches:

Removed the Source System Instance join and retained only contr_src_name and contr_src_id.
Updated the join to use the correct Source System Instance mapping.

Both approaches returned the same result (26 records).

I also validated duplicates across both test tables, silver_rdm_contract_add, and silver_rdm_contract using contr_src_name and contr_src_id. No duplicates were found.

As contr_src_name and contr_src_id already form a unique key, and the Source System Instance field is not required for UDM ingestion, the recommended solution is to remove the Source System Instance join and retain the existing two join keys.

The code change can be included as part of the release. After deployment and validation, the Contract Power Automate flow can be enabled.