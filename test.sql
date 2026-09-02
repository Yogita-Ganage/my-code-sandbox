S1 Delivery Method Investigation / Implementation Update
Reviewed the S1 definitions for del_meth_src_name, del_meth_src_sys_inst_id and del_meth_src_id, including the examples provided for Face to Face and Telephone delivery methods.
Investigated the available S1 source tables and mappings, including the appointment, referral, configured list option, mapping and rota-slot/appointment bridging data, to identify where the delivery method and its source ID could be obtained.
Used silver_sone_srrotaslot_bridging_to_srappointment to link the appointment/referral records to the rota information because this provides the required rota_slot_type, rota_type and organisation/source context.
Validated the logic using the example Referral ID 75902966. This referral returned two appointments:
Initial Consultation F2F / Bromley Physio
Initial Consultation Remote / Bromley Physio Direct
Based on the definition examples, derived the delivery method from rota_slot_type, e.g. F2F → Face to Face and Remote → Telephone, and combined this with rota_type to produce values such as:
Face to Face - Bromley Physio
Telephone - Bromley Physio Direct
Derived del_meth_src_sys_inst_id using the S1 organisation/source context, e.g. SONE00D1Z.
Investigated whether an existing numeric source ID could be used for del_meth_src_id. id_rota_from_rotaslot was considered, but validation showed that the same rota ID can relate to multiple delivery-method combinations, with some rota IDs returning 6–7 different delivery methods. Therefore, it cannot uniquely identify the delivery method.
Also confirmed that Referral ID cannot be used as the delivery method source ID because a single referral can contain multiple appointments with different delivery methods.
No separate source-system ID specifically representing the delivery method was identified in the available S1 data. Therefore, in line with the definition stating that the ID should be derived when a source ID is not available, a derived del_meth_src_id was created using the system instance and delivery-method combination.
Compared the previous approach with the revised logic. The old solution returned approximately 1,540 records, while the revised delivery-method-level solution returned 159 distinct records.
Shared the revised output and example-record validation with Eve for confirmation.
Eve advised that, where possible, values should be extracted from source as-is rather than transformed in engineering code, to avoid future rework if source values change. She has asked how the derived delivery method was obtained.
Explained that the current Face to Face/Telephone derivation was based on the supplied definition/examples and the S1 rota_slot_type values. Awaiting confirmation on whether to keep this derivation or retain the original source values such as Initial Consultation F2F and Initial Consultation Remote.
Final S1 logic will be confirmed once this business/definition clarification is received.

Current status: S1 source investigation, mapping and validation completed. Logic is implemented/tested, but final confirmation is pending on whether the delivery-method value should be derived from the definition examples or retained exactly as supplied by the source.