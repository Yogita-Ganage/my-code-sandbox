SELECT
    id AS referral_id,
    id_organisation_source,
    id_patient,
    date_referral,
    date_discharge
FROM silver_sone_srreferralin
WHERE id_organisation_source = 'G4B9E'
  AND id IN (76346749, 76059032);



  SELECT *
FROM silver_sone_srpatient
WHERE id_organisation_source = 'G4B9E'
  AND id IN (66173613, 66164204);