WITH base AS (
    SELECT DISTINCT
        srref.id AS referral_id,
        sra.id AS appointment_id,
        sra.id_organisation_source,
        bridgetoapp.rota_slot_type,
        bridgetoapp.rota_type
    FROM silver_sone_srappointment sra

    LEFT JOIN silver_sone_srreferralin srref
        ON srref.id = sra.id_referral_in

    LEFT JOIN silver_sone_srrotaslot_bridging_to_srappointment bridgetoapp
        ON CONCAT('SONE', sra.id_organisation, sra.id) = bridgetoapp.src_session_id
        AND sra.id_organisation = bridgetoapp.id_organisation_source

    WHERE srref.id = 75902966
),

mapped AS (
    SELECT *,
        CASE
            WHEN LOWER(TRIM(rota_slot_type)) LIKE '%f2f%'
              OR LOWER(TRIM(rota_slot_type)) LIKE '%face to face%'
                THEN 'Face to Face'

            WHEN LOWER(TRIM(rota_slot_type)) LIKE '%remote%'
              OR LOWER(TRIM(rota_slot_type)) LIKE '%telephone%'
                THEN 'Telephone'

            WHEN LOWER(TRIM(rota_slot_type)) LIKE '%video%'
                THEN 'Video'

            ELSE 'Unmapped'
        END AS derived_delivery_method
    FROM base
)

SELECT
    referral_id,
    appointment_id,
    rota_slot_type,
    rota_type,
    derived_delivery_method,

    CONCAT(
        derived_delivery_method,
        ' - ',
        TRIM(rota_type)
    ) AS del_meth_src_name,

    CONCAT(
        'SONE',
        id_organisation_source
    ) AS del_meth_src_sys_inst_id

FROM mapped
ORDER BY appointment_id;