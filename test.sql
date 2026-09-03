SELECT
    CASE
        WHEN session_del_meth_id IS NULL THEN 'NULL'
        ELSE 'NOT NULL'
    END AS session_del_meth_id_status,
    COUNT(*) AS record_count
FROM <TEST_TABLE>
WHERE z_src_system_id = 'MPB'
GROUP BY
    CASE
        WHEN session_del_meth_id IS NULL THEN 'NULL'
        ELSE 'NOT NULL'
    END;


SELECT 'Production' AS table_name, COUNT(*) AS row_count
FROM silver_sessions
WHERE z_src_system_id = 'MPB'

UNION ALL

SELECT 'Test' AS table_name, COUNT(*) AS row_count
FROM <TEST_TABLE>
WHERE z_src_system_id = 'MPB';


SELECT
    del_meth_src_id,
    COUNT(*) AS cnt
FROM silver_rdm_delivery_method
WHERE del_meth_src_id LIKE 'MPB001_%'
GROUP BY del_meth_src_id
HAVING COUNT(*) > 1
ORDER BY cnt DESC;