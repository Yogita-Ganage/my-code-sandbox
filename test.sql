-- Prefer active record (removed_data = 0) when duplicate source sessions exist
FROM (
    SELECT * FROM (
        SELECT *, ROW_NUMBER() OVER (
            PARTITION BY id_organisation_source, id
            ORDER BY COALESCE(removed_data, 2)
        ) rn
        FROM silver_sone_srappointment
    ) x WHERE rn = 1
) sra


%%sql

SELECT
    COALESCE(removed_data, 2) AS removed_data_group,
    COUNT(*) AS record_count
FROM silver_sone_srappointment
GROUP BY COALESCE(removed_data, 2)
ORDER BY removed_data_group;
