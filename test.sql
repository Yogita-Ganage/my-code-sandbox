WITH validation AS
(
    SELECT
        CASE
            WHEN bridgetoapp.src_session_id IS NULL
                THEN '1 - No bridging record'

            WHEN bridgetoapp.cprod_src_id IS NULL
                 OR TRIM(bridgetoapp.cprod_src_id) = ''
                THEN '2 - Bridge cprod_src_id is blank'

            WHEN rdmcp.cprod_src_id IS NULL
                THEN '3 - Bridge ID not found in RDM Care Product'

            WHEN rdmcp.cprod_src_name IS NULL
                 OR TRIM(rdmcp.cprod_src_name) = ''
                THEN '4 - RDM matched but source name is blank'

            WHEN rdmcp.cprod_id IS NULL
                THEN '5 - RDM matched and name available, but cprod_id is null'

            ELSE '6 - Fully mapped'
        END AS mapping_status
    FROM silver_sone_srappointment sra

    LEFT JOIN silver_sone_srrotaslot_bridging_to_srappointment bridgetoapp
        ON CONCAT('SONE', sra.id_organisation, sra.id)
           = bridgetoapp.src_session_id
       AND sra.id_organisation
           = bridgetoapp.id_organisation_source

    LEFT JOIN silver_rdm_care_product rdmcp
        ON LOWER(TRIM(rdmcp.cprod_src_id))
           = LOWER(TRIM(bridgetoapp.cprod_src_id))

    WHERE CONCAT('SONE', sra.id_organisation, sra.id_patient)
          = 'SONE00D1260771749'
)

SELECT
    mapping_status,
    COUNT(*) AS record_count
FROM validation
GROUP BY mapping_status
ORDER BY mapping_status;