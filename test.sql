SELECT
    RowIdentifier,
    COUNT(DISTINCT id_organisation_source) AS organisation_count,
    COLLECT_SET(id_organisation_source) AS organisations
FROM bronze_sone_srappointmentflags
GROUP BY RowIdentifier
HAVING COUNT(DISTINCT id_organisation_source) > 1
ORDER BY organisation_count DESC;



SELECT
    RowIdentifier,
    id_organisation_source,
    FILEDATE,
    to_date(
        reverse(substring(reverse(FILEDATE), 5, 8)),
        'yyyyMMdd'
    ) AS file_date
FROM bronze_sone_srappointmentflags
WHERE RowIdentifier = 2284411412712
ORDER BY id_organisation_source, file_date DESC;