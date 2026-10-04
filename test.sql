UPDATE silver_rdm_delete_config
SET
    instance_filter_column = 'cprod_src_sys_inst_id0',
    instance_filter_type   = 'LOOKUP',
    lookup_column_name     = 'cprod_src_sys_inst_id0'
WHERE config_id = 7;