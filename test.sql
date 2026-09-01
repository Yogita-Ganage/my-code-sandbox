sone_source AS (
    SELECT DISTINCT
        CONCAT(
            'SONE',
            id_organisation_source,
            '_',
            LOWER(TRIM(CONCAT(derived_delivery_method, ' - ', rota_type)))
        ) AS del_meth_src_id,

        CONCAT(
            'SONE',
            id_organisation_source
        ) AS del_meth_src_sys_inst_id,

        CONCAT(
            derived_delivery_method,
            ' - ',
            TRIM(rota_type)
        ) AS del_meth_src_name

    FROM (
        SELECT DISTINCT
            bridgetoapp.id_organisation_source,
            bridgetoapp.rota_type,

            CASE
                WHEN LOWER(TRIM(bridgetoapp.rota_slot_type)) LIKE '%f2f%'
                  OR LOWER(TRIM(bridgetoapp.rota_slot_type)) LIKE '%face to face%'
                    THEN 'Face to Face'

                WHEN LOWER(TRIM(bridgetoapp.rota_slot_type)) LIKE '%remote%'
                  OR LOWER(TRIM(bridgetoapp.rota_slot_type)) LIKE '%telephone%'
                    THEN 'Telephone'

                WHEN LOWER(TRIM(bridgetoapp.rota_slot_type)) LIKE '%video%'
                    THEN 'Video'

                ELSE NULL
            END AS derived_delivery_method

        FROM silver_sone_srappointment sra

        LEFT JOIN silver_sone_srrotaslot_bridging_to_srappointment bridgetoapp
            ON CONCAT('SONE', sra.id_organisation, sra.id) = bridgetoapp.src_session_id
            AND sra.id_organisation = bridgetoapp.id_organisation_source

        WHERE bridgetoapp.rota_slot_type IS NOT NULL
    ) sone

    WHERE derived_delivery_method IS NOT NULL
),