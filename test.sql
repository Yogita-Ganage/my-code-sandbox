Implemented session_del_meth_id logic for WIP.
Delivery Method is derived using Service Type + Service + Activity Type, with del_meth_src_id built as WIP001_<service_type_id>_<service_id>_<activity_type_id>. This is matched to silver_rdm_delivery_method to populate the corresponding del_meth_id.

Validation completed in PROD test table:

session_del_meth_id populated for 987,023 WIP records.
17 records remain NULL; validation confirmed these have a missing Service Type ID and are intentionally excluded from the Delivery Method ADD logic.
No duplicate WIP del_meth_src_id values found in silver_rdm_delivery_method.
Spot checks confirmed the generated Delivery Method source IDs match the RDM source IDs and return the expected del_meth_id.