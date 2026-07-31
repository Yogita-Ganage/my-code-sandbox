Investigated the UAT failure for cprod_src_name using the example session_patient_id = SONE00D1260771749.

Validated the current production mapping flow from SRAppointment through the bridging table to silver_rdm_care_product. Out of 16 records, 14 were fully mapped and 2 had no matching care product record in silver_rdm_care_product.

The two unmatched bridge_cprod_src_id values were also checked in the Care Product ADD test table, Care Product ADD table, and silver_rdm_care_product; they were not present in any of these tables.

Source-level validation confirmed that the relevant RotaSlotType and RotaType combinations exist, but their BlockedSlot value is true.

The attribute definition specifies BlockedSlot = 0, and the current ADD code applies s.blocked_slot = false. Therefore, these records are excluded as per the agreed definition.

Conclusion: The current implementation matches the attribute definition. The reported blank cprod_src_name values are for blocked-slot records that are expected to be excluded. No code change is required based on the current definition. Please confirm whether the UAT expectation needs to be updated or whether the business definition should include blocked slots.





Hi [Name], I investigated the UAT failure for cprod_src_name. The current implementation matches the attribute definition (BlockedSlot = 0). The failing records have BlockedSlot = true, so they are excluded by design.Could you please confirm whether the definition or the UAT expectation needs to be updated?