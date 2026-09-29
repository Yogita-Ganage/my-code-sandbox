SELECT
    CASE
        WHEN st.session_care_epi_id IS NULL THEN 'NO STAGING MATCH'
        ELSE 'STAGING MATCH'
    END AS staging_match_status,
    COUNT(*) AS record_count
FROM test_silver_care_episode1 ce
LEFT JOIN test_silver_staging_completion_status_conformed st
    ON ce.care_epi_id = st.session_care_epi_id
WHERE ce.z_src_system_id = 'MPB'
GROUP BY
    CASE
        WHEN st.session_care_epi_id IS NULL THEN 'NO STAGING MATCH'
        ELSE 'STAGING MATCH'
    END;



WITH null_episodes AS (
    SELECT DISTINCT care_epi_id
    FROM test_silver_care_episode1
    WHERE z_src_system_id = 'MPB'
      AND care_epi_completion_status_conformed IS NULL
),

session_ids AS (
    SELECT DISTINCT session_care_epi_id
    FROM silver_sessions
    WHERE session_care_epi_id LIKE 'MPB%'
)

SELECT
    CASE
        WHEN s.session_care_epi_id IS NULL THEN 'NO SESSION'
        ELSE 'HAS SESSION'
    END AS session_status,
    COUNT(*) AS care_episode_count
FROM null_episodes n
LEFT JOIN session_ids s
    ON n.care_epi_id = s.session_care_epi_id
GROUP BY
    CASE
        WHEN s.session_care_epi_id IS NULL THEN 'NO SESSION'
        ELSE 'HAS SESSION'
    END;