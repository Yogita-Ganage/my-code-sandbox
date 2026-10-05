-- ============================================================
-- RDM Controlled Delete Tool - FINAL CONFIGURATION
-- ============================================================

-- 1. Care Product
UPDATE silver_rdm_delete_config
SET
    instance_filter_column = NULL,
    instance_filter_type   = 'LOOKUP',
    lookup_column_name     = 'cprod_src_sys_inst_id0',
    text_column_name       = NULL,
    active_flag            = TRUE
WHERE rdm_list_name = 'RDM - Care Product';


-- 2. Service
UPDATE silver_rdm_delete_config
SET
    instance_filter_column = 'service_src_sys_inst_id',
    instance_filter_type   = 'TEXT',
    lookup_column_name     = NULL,
    text_column_name       = NULL,
    active_flag            = TRUE
WHERE rdm_list_name = 'RDM - Service';


-- 3. Delivery Method
UPDATE silver_rdm_delete_config
SET
    instance_filter_column = NULL,
    instance_filter_type   = 'LOOKUP',
    lookup_column_name     = 'cprod_src_sys_inst_id0',
    text_column_name       = NULL,
    active_flag            = TRUE
WHERE rdm_list_name = 'RDM - Delivery Method';


-- 4. Form Question
UPDATE silver_rdm_delete_config
SET
    instance_filter_column = NULL,
    instance_filter_type   = 'LOOKUP',
    lookup_column_name     = 'cprod_src_sys_inst_id0',
    text_column_name       = NULL,
    active_flag            = TRUE
WHERE rdm_list_name = 'RDM - Form Question';


-- 5. Contract
UPDATE silver_rdm_delete_config
SET
    instance_filter_column = NULL,
    instance_filter_type   = 'LOOKUP',
    lookup_column_name     = 'contr_src_sys_inst_id_new',
    text_column_name       = NULL,
    active_flag            = TRUE
WHERE rdm_list_name = 'RDM - Contract';


-- 6. Form Answer Bridging
-- Currently not required
UPDATE silver_rdm_delete_config
SET
    text_column_name = NULL,
    active_flag      = FALSE
WHERE rdm_list_name = 'RDM - Form Answer Bridging';


-- 7. Session Status
-- If row already exists, update it
UPDATE silver_rdm_delete_config
SET
    instance_filter_column = NULL,
    instance_filter_type   = 'LOOKUP',
    lookup_column_name     = 'session_status_src_sys_inst_id1',
    text_column_name       = NULL,
    active_flag            = TRUE
WHERE rdm_list_name = 'RDM - Session Status';