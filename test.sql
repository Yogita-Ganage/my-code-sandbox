EVALUATE
SELECTCOLUMNS(
    FILTER(
        'silver_rdm_delete_config',
        'silver_rdm_delete_config'[active_flag] = TRUE()
    ),
    "config_id", 'silver_rdm_delete_config'[config_id],
    "rdm_list_name", 'silver_rdm_delete_config'[rdm_list_name],
    "instance_filter_column", 'silver_rdm_delete_config'[instance_filter_column],
    "instance_filter_type", 'silver_rdm_delete_config'[instance_filter_type],
    "lookup_column_name", 'silver_rdm_delete_config'[lookup_column_name],
    "text_column_name", 'silver_rdm_delete_config'[text_column_name]
)