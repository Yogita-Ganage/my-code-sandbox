%%sql

UPDATE silver_rdm_delete_config
SET instance_filter_column =
    CASE
        WHEN rdm_list_name = 'RDM - Care Product'
            THEN 'PASTE_CARE_PRODUCT_INTERNAL_NAME'

        WHEN rdm_list_name = 'RDM - Service'
            THEN 'PASTE_SERVICE_INTERNAL_NAME'

        WHEN rdm_list_name = 'RDM - Delivery Method'
            THEN 'PASTE_DELIVERY_METHOD_INTERNAL_NAME'

        WHEN rdm_list_name = 'RDM - Form Answer Bridging'
            THEN 'PASTE_FORM_ANSWER_BRIDGING_INTERNAL_NAME'

        WHEN rdm_list_name = 'RDM - Form Question'
            THEN 'PASTE_FORM_QUESTION_INTERNAL_NAME'

        WHEN rdm_list_name = 'RDM - Contract'
            THEN 'PASTE_CONTRACT_INTERNAL_NAME'

        ELSE instance_filter_column
    END
WHERE rdm_list_name IN (
    'RDM - Care Product',
    'RDM - Service',
    'RDM - Delivery Method',
    'RDM - Form Answer Bridging',
    'RDM - Form Question',
    'RDM - Contract'
);