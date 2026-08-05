SELECT
    user_id,
    COUNT(*) AS row_count
FROM silver_staging_mpb_pathway
WHERE change_num_desc = 1
GROUP BY user_id
HAVING COUNT(*) > 1
ORDER BY row_count DESC;

SELECT *
FROM silver_staging_mpb_pathway
WHERE user_id = '9a1f508e-9624-43c5-86ff-7ebc5d8d289e'
ORDER BY datetime DESC;