SELECT *
FROM silver_sone_srconfigurelistoption
WHERE LOWER(configured_list_option) LIKE '%initial consultation f2f%'
   OR LOWER(configured_list_option) LIKE '%initial consultation remote%'
   OR LOWER(configured_list_option) LIKE '%face to face%'
   OR LOWER(configured_list_option) LIKE '%telephone%'
   OR LOWER(configured_list_option) LIKE '%video%';



SELECT *
FROM silver_sone_srmapping
WHERE LOWER(mapping) LIKE '%face%'
   OR LOWER(mapping) LIKE '%telephone%'
   OR LOWER(mapping) LIKE '%video%'
   OR LOWER(mapping) LIKE '%f2f%'
   OR LOWER(mapping) LIKE '%remote%';


   SELECT DISTINCT
    srref.id AS referral_id,
    sra.*,
    bridgetoapp.rota_slot_type,
    bridgetoapp.rota_type,
    bridgetoapp.id_organisation_source
FROM silver_sone_srappointment sra

LEFT JOIN silver_sone_srreferralin srref
    ON srref.id = sra.id_referral_in

LEFT JOIN silver_sone_srrotaslot_bridging_to_srappointment bridgetoapp
    ON CONCAT('SONE', sra.id_organisation, sra.id) = bridgetoapp.src_session_id
   AND sra.id_organisation = bridgetoapp.id_organisation_source

WHERE srref.id = 75902966;