Updated the SONE care_epi_contr_id logic to align with the attribute definition by matching the RDM Contract using contr_src_name and contr_src_id.

Validation confirmed that the join logic is working. The remaining NULL values are because most SONE contracts are currently present in silver_rdm_contract_add but are not yet available in the main silver_rdm_contract table, so a SharePoint-generated contr_id is not yet available for those records.

Current validation:

Total records: 572,846
Non-null care_epi_contr_id: 94
Null: 572,752

The code change is complete; remaining NULLs are dependent on the RDM Contract entries being promoted into the main RDM table.