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
    <NEXT_FREE_CONFIG_ID>,
    'RDM - Session Status',
    NULL,
    'LOOKUP',
    'session_status_src_sys_inst_id1',
    NULL,
    TRUE
);