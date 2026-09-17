-- Keep the latest active primary referral reason per referral to prevent duplicate session rows

LEFT JOIN (
    SELECT * FROM (
        SELECT *, ROW_NUMBER() OVER (
            PARTITION BY id_referral_in
            ORDER BY date_event_recorded DESC, id DESC
        ) rn
        FROM silver_sone_srreferralinreferralreason
        WHERE primary_referral_reason = 1 AND date_removed IS NULL
    ) x WHERE rn = 1
) srrefcr
ON srrefcr.id_referral_in = sra.id_referral_in