%%sql

SELECT
    id,
    id_organisation_source,
    id_referral_in
FROM silver_sone_srappointment
WHERE id = 35161102865
  AND id_organisation_source = 'NLF11';

  %%sql

SELECT *
FROM silver_sone_srreferralinreferralreason
WHERE id_referral_in = < id_referral_in>
  AND primary_referral_reason = 1
  AND date_removed IS NULL;


  %%sql

SELECT
    rr.referral_reason,
    cfg.configured_list_option
FROM silver_sone_srreferralinreferralreason rr
LEFT JOIN silver_sone_srconfiguredlistoption cfg
    ON cfg.id = rr.referral_reason
WHERE rr.id_referral_in = < id_referral_in>
  AND rr.primary_referral_reason = 1
  AND rr.date_removed IS NULL;