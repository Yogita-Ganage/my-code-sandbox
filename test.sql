SELECT
    title,
    COUNT(*) AS row_count
FROM silver_drj_anamnesises_epicrisis
WHERE user_id = '9a1f508e-9624-43c5-86ff-7ebc5d8d289e'
  AND title IN (
      'Discharge Reason',
      'Discharge Status',
      'Treatment Type'
  )
GROUP BY title
ORDER BY title;