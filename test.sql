SELECT
    session_care_epi_id,
    COUNT(*) AS row_count
FROM (
    SELECT
        session_care_epi_id,
        MAX(session_attended_flag) AS session_attended_flag,
        MAX(session_bkd_in_future_flag) AS session_bkd_in_future_flag
    FROM silver_sessions
    GROUP BY session_care_epi_id
) session_flags_comb
WHERE session_care_epi_id =
      'MPB0019a1f508e-9624-43c5-86ff-7ebc5d8d289e'
GROUP BY session_care_epi_id;