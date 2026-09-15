%%sql

WITH dup_session AS (
    SELECT src_session_id
    FROM silver_sessions_sone_test
    WHERE src_session_id IS NOT NULL
    GROUP BY src_session_id
    HAVING COUNT(*) > 1
    LIMIT 1
)

SELECT
    s.src_session_id,
    s.session_cprod_id,

    b.cprod_src_id AS bridge_cprod_src_id,

    r.cprod_id AS rdm_cprod_id,
    r.cprod_src_id AS rdm_cprod_src_id,
    r.cprod_src_sys_inst_src_id,
    r.cprod_src_name

FROM silver_sessions_sone_test s

INNER JOIN dup_session d
    ON s.src_session_id = d.src_session_id

LEFT JOIN silver_sone_srrotaslot_bridging_to_srappointment b
    ON s.src_session_id = b.src_session_id

LEFT JOIN silver_rdm_care_product r
    ON LOWER(TRIM(r.cprod_src_id))
     = LOWER(TRIM(b.cprod_src_id))

ORDER BY
    s.src_session_id,
    s.session_cprod_id,
    r.cprod_id;