ALTER TABLE silver_rdm_delete_config
ALTER COLUMN config_id
COMMENT 'Unique config row ID';

ALTER TABLE silver_rdm_delete_config
ALTER COLUMN rdm_list_name
COMMENT 'RDM SharePoint list name';

ALTER TABLE silver_rdm_delete_config
ALTER COLUMN instance_filter_type
COMMENT 'Filter type: TEXT or LOOKUP';

ALTER TABLE silver_rdm_delete_config
ALTER COLUMN instance_filter_column
COMMENT 'Internal column name used for TEXT filter';

ALTER TABLE silver_rdm_delete_config
ALTER COLUMN lookup_column_name
COMMENT 'Internal lookup column name used for LOOKUP filter';

ALTER TABLE silver_rdm_delete_config
ALTER COLUMN text_column_name
COMMENT 'SharePoint visible column name';

ALTER TABLE silver_rdm_delete_config
ALTER COLUMN active_flag
COMMENT 'TRUE = available in delete tool';





-- 1. Store SharePoint Display Name / Column Title
--    This is for reference/readability only.
--    Flow filtering does NOT use this column.

UPDATE silver_rdm_delete_config
SET text_column_name =
    CASE rdm_list_name

        WHEN 'RDM - Care Product'
            THEN 'cprod_src_sys_inst_id'

        WHEN 'RDM - Service'
            THEN 'service_src_sys_inst_id'

        WHEN 'RDM - Delivery Method'
            THEN 'del_meth_src_sys_inst_id'

        WHEN 'RDM - Form Question'
            THEN 'form_ques_src_sys_inst_id'

        WHEN 'RDM - Contract'
            THEN 'contr_src_sys_inst_id'

        WHEN 'RDM - Session Status'
            THEN 'session_status_src_sys_inst_id'

        WHEN 'RDM - Yogita - TEST'
            THEN 'test_sp_src_sys_inst_id'

        ELSE text_column_name
    END;
