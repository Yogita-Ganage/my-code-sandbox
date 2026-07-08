SELECT
    id,
    id_organisation_source,
    date_start,
    date_end
FROM silver_sone_srappointment
WHERE date_start IS NOT NULL
LIMIT 20;

SELECT
    COUNT(*) AS total_appointments,
    SUM(CASE WHEN date_start IS NULL THEN 1 ELSE 0 END) AS blank_date_start_count,
    SUM(CASE WHEN date_start IS NOT NULL THEN 1 ELSE 0 END) AS populated_date_start_count,
    MIN(date_start) AS min_date_start,
    MAX(date_start) AS max_date_start
FROM silver_sone_srappointment;