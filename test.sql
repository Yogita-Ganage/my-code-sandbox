SELECT DISTINCT
    a.id AS appointment_id,
    a.id_referral_in AS case_reference,
    a.id_organisation_source,
    a.date_start,
    a.rota_type,
    s.rota_slot_type
FROM silver.silver_sone_srappointment a

LEFT JOIN silver.silver_sone_srrotaslot s
    ON a.id_rota = s.id_rota

WHERE COALESCE(TRIM(a.rota_type), '') = ''
  AND COALESCE(TRIM(s.rota_slot_type), '') = ''

LIMIT 10;