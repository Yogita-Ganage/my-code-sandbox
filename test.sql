%%sql

DROP TABLE IF EXISTS silver_rdm_delivery_method_add;

CREATE TABLE silver_rdm_delivery_method_add AS

WITH sone_source AS
(
    SELECT DISTINCT

        /* Delivery Method Source ID */
        CONCAT(
            'SONE',
            sra.id_organisation,
            '_',
            LOWER(
                CONCAT(
                    CASE
                        WHEN LOWER(TRIM(bridgetoapp.rota_slot_type))
                             = 'initial consultation f2f'
                            THEN 'Face to Face'

                        WHEN LOWER(TRIM(bridgetoapp.rota_slot_type))
                             = 'initial consultation remote'
                            THEN 'Telephone'
                    END,
                    ' - ',
                    TRIM(bridgetoapp.rota_type)
                )
            )
        ) AS del_meth_src_id,


        /* Delivery Method Source System Instance ID */
        CONCAT(
            'SONE',
            sra.id_organisation
        ) AS del_meth_src_sys_inst_id,


        /* Delivery Method Source Name */
        CONCAT(
            CASE
                WHEN LOWER(TRIM(bridgetoapp.rota_slot_type))
                     = 'initial consultation f2f'
                    THEN 'Face to Face'

                WHEN LOWER(TRIM(bridgetoapp.rota_slot_type))
                     = 'initial consultation remote'
                    THEN 'Telephone'
            END,
            ' - ',
            TRIM(bridgetoapp.rota_type)
        ) AS del_meth_src_name


    FROM silver_sone_srappointment sra

    LEFT JOIN silver_sone_srrotaslot_bridging_to_srappointment bridgetoapp
        ON CONCAT(
               'SONE',
               sra.id_organisation,
               sra.id
           ) = bridgetoapp.src_session_id

       AND sra.id_organisation
           = bridgetoapp.id_organisation_source


    /* Only the two exact mappings supplied in the definition */
    WHERE LOWER(TRIM(bridgetoapp.rota_slot_type)) IN
          (
              'initial consultation f2f',
              'initial consultation remote'
          )

      AND bridgetoapp.rota_type IS NOT NULL
)


SELECT DISTINCT
    s.del_meth_src_id,
    s.del_meth_src_sys_inst_id,
    s.del_meth_src_name

FROM sone_source s

LEFT JOIN silver_rdm_delivery_method rdm
    ON LOWER(TRIM(rdm.del_meth_src_name))
       = LOWER(TRIM(s.del_meth_src_name))

   AND LOWER(TRIM(rdm.del_meth_src_sys_inst_id))
       = LOWER(TRIM(s.del_meth_src_sys_inst_id))

WHERE rdm.del_meth_src_name IS NULL;





%%sql

SELECT *
FROM silver_rdm_delivery_method_add
ORDER BY del_meth_src_sys_inst_id,
         del_meth_src_name;