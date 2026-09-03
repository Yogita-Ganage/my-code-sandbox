,rdmdelmeth.del_meth_id AS session_del_meth_id

LEFT JOIN silver_rdm_delivery_method rdmdelmeth ON LOWER(TRIM(rdmdelmeth.del_meth_src_id)) = LOWER(TRIM(CONCAT('SONE', bridgetoapp.id_organisation_source, '_', LOWER(CONCAT(TRIM(bridgetoapp.rota_slot_type), '_', TRIM(bridgetoapp.rota_type))))))