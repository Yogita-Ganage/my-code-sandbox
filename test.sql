SELECT
    id_organisation_source,
    COUNT(*) AS row_count
FROM silver_sone_srcode
WHERE id_referral_in IS NOT NULL
GROUP BY id_organisation_source
ORDER BY row_count DESC;