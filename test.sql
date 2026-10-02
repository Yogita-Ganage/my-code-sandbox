%%sql

INSERT INTO silver_rdm_delete_config
(
    config_id,
    rdm_list_name,
    instance_filter_column,
    instance_filter_type,
    lookup_column_name,
    text_column_name,
    active_flag
)
VALUES
(
    1,
    'RDM - Care Product',
    'cprod_src_sys_inst_src_id',
    'TEXT',
    'cprod_src_sys_inst_id',
    'cprod_src_sys_inst_src_id',
    true
),
(
    2,
    'RDM - Service',
    'service_src_sys_inst_id',
    'TEXT',
    NULL,
    'service_src_sys_inst_id',
    true
);