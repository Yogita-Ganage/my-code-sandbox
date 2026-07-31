SELECT *
FROM <care_product_add_test_table>
WHERE LOWER(TRIM(cprod_src_id)) IN
(
    LOWER(TRIM('<first_unmatched_bridge_cprod_src_id>')),
    LOWER(TRIM('<second_unmatched_bridge_cprod_src_id>'))
);