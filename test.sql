SELECT
    referral_source,
    z_src_system_id,
    COUNT(*) AS row_count
FROM silver_rdm_referral_source
GROUP BY
    referral_source,
    z_src_system_id
HAVING COUNT(*) > 1
ORDER BY row_count DESC;

SELECT *
FROM silver_rdm_referral_source
WHERE TRIM(LOWER(referral_source)) = '<duplicate_referral_source>';

SELECT
    care_epi_referral_source,
    z_src_system_id,
    COUNT(*) AS row_count
FROM silver_rdm_referral_source_add
GROUP BY
    care_epi_referral_source,
    z_src_system_id
HAVING COUNT(*) > 1;