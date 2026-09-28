SELECT
    rota_type,
    id_organisation_source,
    COUNT(DISTINCT id_rota) AS rota_id_count
FROM silver_sone_srappointment
WHERE rota_type IS NOT NULL
GROUP BY
    rota_type,
    id_organisation_source
HAVING COUNT(DISTINCT id_rota) > 1
ORDER BY rota_id_count DESC;