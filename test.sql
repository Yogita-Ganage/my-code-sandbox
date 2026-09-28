WITH test_check AS
(
    SELECT DISTINCT
        c.case_pk,
        c.database_source,
        c.case_first_appointment_fk,

        appt.appointment_pk,
        appt.stock_item_fk,

        si.stock_item_description,

        CONCAT(
            c.database_source,
            ' - ',
            TRIM(si.stock_item_description)
        ) AS constructed_cprod_src_id,

        rdmcc.cprod_src_id,
        rdmcc.cprod_src_sys_inst_id,
        rdmcc.cprod_type_conformed,

        CASE
            WHEN LOWER(rdmcc.cprod_type_conformed) LIKE '%test%'
            THEN 1
            ELSE 0
        END AS expected_care_epi_is_test

    FROM silver_tm3_dim_cases c

    LEFT JOIN silver_tm3_fact_appointments appt
        ON c.case_first_appointment_fk = appt.appointment_pk
       AND appt.practitioner_fk <> 0
       AND c.database_source = appt.database_source

    LEFT JOIN silver_tm3_dim_stock_items si
        ON appt.stock_item_fk = si.stock_item_pk
       AND appt.database_source = si.database_source

    LEFT JOIN silver_rdm_care_product rdmcc
        ON LOWER(TRIM(rdmcc.cprod_src_id))
         = LOWER(
             TRIM(
                 CONCAT(
                     c.database_source,
                     ' - ',
                     TRIM(si.stock_item_description)
                 )
             )
           )
       AND rdmcc.cprod_src_sys_inst_id = c.database_source

    LEFT JOIN silver_tm3_dim_case_deletions dcd
        ON c.case_pk = dcd.case_pk
       AND c.database_source = dcd.database_source

    WHERE dcd.deleted_at IS NULL
)

SELECT
    expected_care_epi_is_test,
    COUNT(*) AS record_count
FROM test_check
GROUP BY expected_care_epi_is_test
ORDER BY expected_care_epi_is_test;