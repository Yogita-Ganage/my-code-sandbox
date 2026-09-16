%%sql

SELECT
    CONCAT('SONE', id_organisation_source, id) AS src_session_id,
    COUNT(*) AS row_count,
    COUNT(DISTINCT appointment_status) AS status_cnt,
    COUNT(DISTINCT removed_data) AS removed_data_cnt,
    COLLECT_SET(id_organisation) AS organisations,
    COLLECT_SET(appointment_status) AS statuses,
    COLLECT_SET(removed_data) AS removed_data_values
FROM silver_sone_srappointment
WHERE id_organisation_source IS NOT NULL
GROUP BY
    id_organisation_source,
    id
HAVING COUNT(*) > 1
ORDER BY row_count DESC;

found that a large number of the remaining duplicates were caused by using id_organisation when building the session source ID. I tested using id_organisation_source instead, which aligns with your earlier point about using the source organisation code.

After this change, the duplicate session_src_id count reduced from 681 to 48. I’m now checking the remaining 48 to confirm whether they are coming from the source data itself or another join.
I found the duplicates were happening because different source organisation records were generating the same session_src_id when using id_organisation. I changed the logic to use id_organisation_source instead, and the duplicate count reduced from 681 to 48.