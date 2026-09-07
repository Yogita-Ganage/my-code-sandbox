Updated the WIP care_epi_contr_id logic to align with the attribute definition. Removed the old hardcoded contr_src_sys_inst_id = 'WIP001' condition and matched the RDM Contract using contr_src_name.

Validation completed in PROD test table:

Total records: 439,573
Non-null care_epi_contr_id: 439,572
Null: 1

The updated join is successfully populating the RDM Contract ID for WIP records.