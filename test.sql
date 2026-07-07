SELECT
    session_id,
    session_care_epi_id,
    session_date_confirmed,
    session_start_date_time,
    session_cprod_id
FROM silver_sessions
WHERE
    (
        CAST(session_care_epi_id AS STRING) LIKE '%451027%'
        AND session_date_confirmed = DATE '2025-06-02'
    )
    OR
    (
        CAST(session_care_epi_id AS STRING) LIKE '%306826%'
        AND session_date_confirmed = DATE '2026-04-21'
    )
    OR
    (
        CAST(session_care_epi_id AS STRING) LIKE '%537824%'
        AND session_date_confirmed IN (DATE '2025-06-05', DATE '2025-07-03')
    )
ORDER BY
    session_care_epi_id,
    session_date_confirmed,
    session_start_date_time;