Reviewed the available S1 source IDs to identify whether an existing source-system ID could be used for del_meth_src_id.

The rota_slot_id, id_rota and rota_id values were validated against the source Delivery Method combination (id_organisation_source + rota_slot_type + rota_type). The same Delivery Method combination was found to map to many different rota slot and rota IDs, so these IDs do not uniquely represent the Delivery Method and cannot be used as del_meth_src_id.

As no separate unique Delivery Method ID was identified in the source, del_meth_src_id is derived using:

SONE + id_organisation_source + rota_slot_type + rota_type

This provides one consistent ID for each Delivery Method combination within the S1 system instance and follows the definition allowing the ID to be derived where a source ID is not available.




-- del_meth_src_id: Derived from S1 system instance + rota_slot_type + rota_type, as no unique source Delivery Method ID is available.

-- del_meth_src_name: Uses rota_slot_type + rota_type directly from source with no value transformation.