Updated WIP `session_patient_id` mapping to align with the attribute definition.

The value is now built from `z_src_system_instance` + `client_id` from `silver_wip_activityheaderroledetail`, instead of using the person table ID.

Validated against example care episode `573340`: `client_id = 304007`, expected `session_patient_id = WIP001304007`.