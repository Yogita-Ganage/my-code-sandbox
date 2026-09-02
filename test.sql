Update:

Following Eve’s clarification, the S1 Delivery Method logic was reviewed again so that source values are returned as-is, without deriving/conforming values such as F2F → Face to Face or Remote → Telephone.

Two approaches were then compared for sourcing the Delivery Method values:

Direct source approach using silver_sone_srrotaslot joined to silver_sone_srrota.
Appointment bridge approach using silver_sone_srrotaslot_bridging_to_srappointment.

Validation showed:

Direct source returned 1,398 distinct rota_slot_type + rota_type combinations.
Bridge approach returned 1,124 distinct combinations.
274 combinations were present in the direct source but not in the bridge.
0 combinations were present in the bridge but missing from the direct source.

This confirmed that the bridge is effectively a subset of the direct source and only contains values that have been linked through appointments.

As the definition does not state that only Delivery Methods already used on appointments should be included, the direct source approach was selected. This avoids excluding valid source-configured values that may not yet have been used on an appointment.

Final implementation:

del_meth_src_name uses the source rota_slot_type + rota_type as-is.
del_meth_src_sys_inst_id is derived as SONE + id_organisation_source.
del_meth_src_id is derived from the S1 system instance plus the source Delivery Method combination, as no separate unique Delivery Method source ID was identified.

Final approach: direct silver_sone_srrotaslot → silver_sone_srrota join.