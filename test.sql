-- ============================================================
-- RDM Controlled Delete Tool - Final Configuration Update
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
-- Not currently required, so keep the row but make it inactive
UPDATE silver_rdm_delete_config
SET
    text_column_name = NULL,
    active_flag      = FALSE
WHERE rdm_list_name = 'RDM - Form Answer Bridging';


-- 7. Session Status
-- Run this INSERT only if Session Status does not already exist.
-- Use config_id = 8 only if 8 is free.

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
SELECT
    8,
    'RDM - Session Status',
    NULL,
    'LOOKUP',
    'session_status_src_sys_inst_id1',
    NULL,
    TRUE
WHERE NOT EXISTS
(
    SELECT 1
    FROM silver_rdm_delete_config
    WHERE rdm_list_name = 'RDM - Session Status'
);


-- ============================================================
-- Final Validation
-- ============================================================

SELECT
    config_id,
    rdm_list_name,
    instance_filter_column,
    instance_filter_type,
    lookup_column_name,
    text_column_name,
    active_flag
FROM silver_rdm_delete_config
ORDER BY config_id;