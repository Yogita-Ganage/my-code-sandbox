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



%%sql

WITH grp AS (
    SELECT
        id_organisation_source,
        id,
        MAX(CASE WHEN removed_data = 0 THEN 1 ELSE 0 END) AS has_0,
        MAX(CASE WHEN removed_data = 1 THEN 1 ELSE 0 END) AS has_1,
        MAX(CASE WHEN removed_data IS NULL THEN 1 ELSE 0 END) AS has_null
    FROM silver_sone_srappointment
    GROUP BY id_organisation_source, id
),
final AS (
    SELECT *,
        CASE
            WHEN has_0 = 1 AND has_1 = 1 THEN 'Both 0 and 1'
            WHEN has_0 = 1 AND has_1 = 0 AND has_null = 0 THEN 'Only 0'
            WHEN has_0 = 0 AND has_1 = 1 AND has_null = 0 THEN 'Only 1'
            WHEN has_0 = 0 AND has_1 = 0 AND has_null = 1 THEN 'Only NULL'
            ELSE 'Mixed with NULL'
        END AS group_type
    FROM grp
)
SELECT group_type, COUNT(*) AS session_count
FROM final
GROUP BY group_type;