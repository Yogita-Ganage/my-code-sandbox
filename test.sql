SELECT
    COUNT(*) AS total_rows,
    SUM(CASE WHEN id_organisation_source IS NULL THEN 1 ELSE 0 END) AS null_org_source,
    SUM(CASE WHEN id_referral_in IS NULL THEN 1 ELSE 0 END) AS null_referral,
    SUM(
        CASE
            WHEN id_organisation_source IS NULL
              OR id_referral_in IS NULL
            THEN 1 ELSE 0
        END
    ) AS would_make_care_epi_null
FROM silver_sone_srcode;