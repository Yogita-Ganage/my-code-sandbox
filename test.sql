%%sql

CREATE TABLE IF NOT EXISTS silver_rdm_delete_config
(
    config_id               INT,
    rdm_list_name           STRING,

    -- Actual SharePoint column to use when filtering records for deletion
    instance_filter_column  STRING,

    -- TEXT or LOOKUP
    instance_filter_type    STRING,

    -- Optional: lookup-style instance column if that list has one
    lookup_column_name      STRING,

    -- Optional: text/source-id instance column if that list has one
    text_column_name        STRING,

    active_flag             BOOLEAN
)
USING DELTA;





%%sql

SELECT *
FROM silver_rdm_delete_config;