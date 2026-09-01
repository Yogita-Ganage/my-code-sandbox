SELECT DISTINCT
    srref.id AS referral_id,
    sra.id AS appointment_id,
    sra.id_organisation,
    sra.id_organisation_source,
    bridgetoapp.rota_slot_type,
    bridgetoapp.rota_type
FROM silver_sone_srappointment sra

LEFT JOIN silver_sone_srreferralin srref
    ON srref.id = sra.id_referral_in

LEFT JOIN silver_sone_srrotaslot_bridging_to_srappointment bridgetoapp
    ON CONCAT('SONE', sra.id_organisation, sra.id) = bridgetoapp.src_session_id
    AND sra.id_organisation = bridgetoapp.id_organisation_source

WHERE srref.id = 75902966;




SELECT DISTINCT
    id,
    configured_list,
    configured_list_option,
    id_organisation_source
FROM silver_sone_srconfiguredlistoption
WHERE
       LOWER(configured_list_option) LIKE '%initial consultation%'
    OR LOWER(configured_list_option) LIKE '%face to face%'
    OR LOWER(configured_list_option) LIKE '%telephone%'
    OR LOWER(configured_list_option) LIKE '%remote%'
    OR LOWER(configured_list_option) LIKE '%video%'
ORDER BY configured_list_option;



SELECT DISTINCT
    id,
    id_mapping_group,
    mapping,
    id_organisation_source
FROM silver_sone_srmapping
WHERE
       LOWER(mapping) LIKE '%initial consultation%'
    OR LOWER(mapping) LIKE '%face%'
    OR LOWER(mapping) LIKE '%telephone%'
    OR LOWER(mapping) LIKE '%remote%'
    OR LOWER(mapping) LIKE '%video%'
ORDER BY mapping;