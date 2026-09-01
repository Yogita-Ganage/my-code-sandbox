%%sql

DROP TABLE IF EXISTS s1_delivery_method_test;

CREATE TABLE s1_delivery_method_test AS

WITH base AS
(
    SELECT DISTINCT
        sra.id AS appointment_id,
        sra.id_referral_in AS referral_id,
        sra.id_organisation_source,
        bridgetoapp.rota_slot_type,
        bridgetoapp.rota_type

    FROM silver_sone_srappointment sra

    LEFT JOIN silver_sone_srrotaslot_bridging_to_srappointment bridgetoapp
        ON CONCAT('SONE', sra.id_organisation, sra.id)
            = bridgetoapp.src_session_id
       AND sra.id_organisation
            = bridgetoapp.id_organisation_source

    WHERE bridgetoapp.rota_slot_type IS NOT NULL
      AND bridgetoapp.rota_type IS NOT NULL
),

mapped AS
(
    SELECT DISTINCT
        appointment_id,
        referral_id,
        id_organisation_source,
        rota_slot_type,
        rota_type,

        CASE
            WHEN LOWER(TRIM(rota_slot_type)) LIKE '%f2f%'
              OR LOWER(TRIM(rota_slot_type)) LIKE '%face to face%'
                THEN 'Face to Face'

            WHEN LOWER(TRIM(rota_slot_type)) LIKE '%remote%'
              OR LOWER(TRIM(rota_slot_type)) LIKE '%telephone%'
                THEN 'Telephone'

            WHEN LOWER(TRIM(rota_slot_type)) LIKE '%video%'
                THEN 'Video'

            ELSE NULL
        END AS derived_delivery_method

    FROM base
),

sone_source AS
(
    SELECT DISTINCT

        /* Delivery Method Source ID */
        CONCAT(
            'SONE',
            id_organisation_source,
            '_',
            LOWER(
                CONCAT(
                    derived_delivery_method,
                    ' - ',
                    TRIM(rota_type)
                )
            )
        ) AS del_meth_src_id,

        /* Delivery Method Source System Instance ID */
        CONCAT(
            'SONE',
            id_organisation_source
        ) AS del_meth_src_sys_inst_id,

        /* Delivery Method Source Name */
        CONCAT(
            derived_delivery_method,
            ' - ',
            TRIM(rota_type)
        ) AS del_meth_src_name

    FROM mapped

    WHERE derived_delivery_method IS NOT NULL
)

SELECT DISTINCT
    s.del_meth_src_id,
    s.del_meth_src_sys_inst_id,
    s.del_meth_src_name

FROM sone_source s

LEFT JOIN silver_rdm_delivery_method rdm
    ON LOWER(TRIM(s.del_meth_src_id))
        = LOWER(TRIM(rdm.del_meth_src_id))
   AND LOWER(TRIM(s.del_meth_src_sys_inst_id))
        = LOWER(TRIM(rdm.del_meth_src_sys_inst_id))

WHERE rdm.del_meth_src_id IS NULL;