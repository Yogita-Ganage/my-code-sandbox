%%sql

WITH dup_session AS (
    SELECT src_session_id
    FROM silver_sessions_sone_test
    WHERE src_session_id IS NOT NULL
    GROUP BY src_session_id
    HAVING COUNT(*) > 1
       AND COUNT(DISTINCT session_cprod_id) > 1
    LIMIT 1
),

src AS (
    SELECT
        CONCAT('SONE', sra.id_organisation, sra.id) AS src_session_id,
        sra.id AS appointment_id,
        sra.id_organisation
    FROM silver_sone_srappointment sra
)

SELECT
    s.src_session_id,
    s.session_cprod_id,

    src.appointment_id,
    src.id_organisation AS appointment_org,

    b.id_organisation_source AS bridge_org,
    b.cprod_src_id AS bridge_cprod_src_id,

    r.cprod_id AS rdm_cprod_id,
    r.cprod_src_sys_inst_src_id,
    r.cprod_src_id AS rdm_cprod_src_id,
    r.cprod_src_name

FROM silver_sessions_sone_test s

INNER JOIN dup_session d
    ON s.src_session_id = d.src_session_id

LEFT JOIN src
    ON s.src_session_id = src.src_session_id

LEFT JOIN silver_sone_srrotaslot_bridging_to_srappointment b
    ON s.src_session_id = b.src_session_id
   AND src.id_organisation = b.id_organisation_source

LEFT JOIN silver_rdm_care_product r
    ON LOWER(TRIM(r.cprod_src_id))
     = LOWER(TRIM(b.cprod_src_id))

ORDER BY
    s.src_session_id,
    s.session_cprod_id,
    r.cprod_id;