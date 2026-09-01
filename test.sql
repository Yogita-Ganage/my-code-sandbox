SELECT
    id,
    referral_code,
    id_referral_local,
    id_organisation,
    id_organisation_source
FROM silver_sone_srreferralin
WHERE CAST(id AS STRING) = '75902966'
   OR CAST(referral_code AS STRING) = '75902966'
   OR CAST(id_referral_local AS STRING) = '75902966';