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





"Yesterday I started working on the MPB Care Episode ID UAT failure task. During the investigation, I identified one issue caused by duplicate records in the RDM Pathway mapping. Those duplicate records were ingested on 21 July, so I removed them and reran the dataflow. That issue is now resolved. However, there are still some duplicate Care Episode records remaining, and my investigation indicates they are related to the RDM Referral Source. Today I'll investigate those duplicate Referral Source records, remove them if required, and then revalidate the Care Episode output."