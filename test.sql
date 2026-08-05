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

: I investigated the duplicate records in the RDM Pathway data. I found that duplicate records had been introduced into the SharePoint list on 21 July 2026, so I removed those duplicates using the Power Automate cleanup flow. After that, I reran the Dataflow to refresh the records in the Silver RDM Pathway table. I then revalidated the original High Intensity record, and it now returns a single record as expected. I am currently investigating the remaining duplicate Care Episode records to identify the exact source of the duplication and will provide a further update once the root cause is confirmed.