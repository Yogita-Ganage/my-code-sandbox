Updated the MPB care_epi_contr_id logic to align with the latest definition. The previous join was using the old hardcoded contr_src_sys_inst_id = 'MPB001'. This has been replaced with a join using contr_src_name from silver_rdm_contract, matched to the MPB tenancy name.

Validation in PROD test table:

Total records: 52,380
Non-null care_epi_contr_id: 52,319
Null: 61

The new join is successfully populating the RDM Contract ID for MPB records.