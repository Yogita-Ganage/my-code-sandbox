%%sql

WITH bridge AS (
    SELECT
        src_session_id,
        cprod_src_id
    FROM silver_sone_srrotaslot_bridging_to_srappointment
    WHERE src_session_id IN (
        'SONE00D1Z35100345160',
        'SONE00D1Z35137356890'
    )
)

SELECT
    b.src_session_id,
    b.cprod_src_id AS bridge_cprod_src_id,
    r.cprod_id,
    r.cprod_src_id AS rdm_cprod_src_id,
    r.cprod_src_sys_inst_src_id,
    r.cprod_src_name
FROM bridge b
LEFT JOIN silver_rdm_care_product r
    ON LOWER(TRIM(r.cprod_src_id))
     = LOWER(TRIM(b.cprod_src_id))
ORDER BY
    b.src_session_id,
    r.cprod_id;