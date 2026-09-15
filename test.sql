%%sql

SELECT
    src_session_id,
    COUNT(*) AS row_cnt,
    COUNT(DISTINCT cprod_src_id) AS cprod_cnt,
    COLLECT_SET(cprod_src_id) AS cprod_src_ids
FROM silver_sone_srrotaslot_bridging_to_srappointment
WHERE src_session_id IN (
    'SONE00D1Z35100345160',
    'SONE00D1Z35137356890'
)
GROUP BY src_session_id;