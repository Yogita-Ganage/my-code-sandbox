SELECT
    RowIdentifier,
    COUNT(DISTINCT id_organisation_source) AS organisation_count,
    COLLECT_SET(id_organisation_source) AS organisations
FROM bronze_sone_srappointmentflags
GROUP BY RowIdentifier
HAVING COUNT(DISTINCT id_organisation_source) > 1
ORDER BY organisation_count DESC;