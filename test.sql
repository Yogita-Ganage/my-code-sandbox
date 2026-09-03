Implemented session_del_meth_id logic for WIP using Service Type + Service + Activity Type to derive the Delivery Method source ID and map it to silver_rdm_delivery_method.del_meth_id.

Validation confirmed the mapping logic is correct. session_del_meth_id populated for 987,023 records, with 17 NULL records.

Investigation showed those 17 records have Activity Entry records present, but the corresponding Activity Header records are not available in Bronze/Silver, so Service Type cannot be derived and therefore Delivery Method cannot be mapped.

Neil is currently checking whether the source table has missing/updated Activity Header records. No issue has been identified with the WIP Delivery Method logic itself.