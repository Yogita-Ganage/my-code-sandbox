%%sql

SELECT
    src_session_id,
    COUNT(*) AS row_cnt
FROM silver_sessions_sone_test
WHERE src_session_id IS NOT NULL
GROUP BY src_session_id
HAVING COUNT(*) > 1
ORDER BY row_cnt DESC;


%%sql

SELECT
    src_session_id,
    COUNT(*) AS row_cnt,
    COUNT(DISTINCT session_cprod_id) AS cprod_cnt,
    COUNT(DISTINCT session_contract_id) AS contract_cnt,
    COUNT(DISTINCT session_care_professional_id) AS care_prof_cnt
FROM silver_sessions_sone_test
WHERE src_session_id IS NOT NULL
GROUP BY src_session_id
HAVING COUNT(*) > 1
ORDER BY row_cnt DESC;