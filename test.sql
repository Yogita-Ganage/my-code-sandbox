%%sql

SELECT
    a.id,
    a.id_organisation_source,
    a.id_referral_in,
    rr.referral_reason,
    cfg.configured_list_option,
    rr.primary_referral_reason,
    rr.date_removed,
    rr.date_event_recorded
FROM silver_sone_srappointment a
LEFT JOIN silver_sone_srreferralinreferralreason rr
    ON rr.id_referral_in = a.id_referral_in
   AND rr.primary_referral_reason = 1
   AND rr.date_removed IS NULL
LEFT JOIN silver_sone_srconfiguredlistoption cfg
    ON cfg.id = rr.referral_reason
WHERE a.id IN (35161102865, 35156579502)
  AND a.id_organisation_source = 'NLF11'
ORDER BY a.id, rr.date_event_recorded;