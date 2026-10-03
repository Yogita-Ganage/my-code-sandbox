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
    7,
    'RDM - Yogita - TEST',
    'PASTE_INTERNAL_NAME',
    'TEXT',
    NULL,
    'test_sp_src_sys_inst_src_id',
    TRUE
);