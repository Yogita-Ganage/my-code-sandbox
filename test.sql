Implemented session_del_meth_id logic for MPB.
Joined silver_rdm_delivery_method using del_meth_src_id = CONCAT('MPB001_', appointment_type_id) and populated session_del_meth_id from the corresponding del_meth_id.

Validation completed in PROD test table:

Production MPB row count: 325,301
Test MPB row count: 325,301
session_del_meth_id populated for all 325,301 MPB records
No duplicate MPB del_meth_src_id values found in silver_rdm_delivery_method
Spot-check confirmed correct mappings, e.g. MPB001_1 → 551 (Video), MPB001_2 → 552 (Voice), MPB001_4 → 553 (Face to Face)

No row count impact observed after introducing the RDM join.