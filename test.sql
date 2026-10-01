WITH unmatched AS (
    SELECT
        arans.assessment_answer_id
    FROM silver_drj_assessment_result_for_answers arans
    LEFT JOIN silver_drj_assessment_results ar
        ON arans.assessment_result_id = ar.id
    WHERE ar.id IS NULL
),

unmatched_counts AS (
    SELECT
        assessment_answer_id,
        COUNT(*) AS base_rows
    FROM unmatched
    GROUP BY assessment_answer_id
),

answer_counts AS (
    SELECT
        id,
        COUNT(*) AS answer_table_rows
    FROM silver_drj_assessment_answers
    GROUP BY id
)

SELECT
    SUM(u.base_rows * (a.answer_table_rows - 1)) AS total_extra_rows
FROM unmatched_counts u
JOIN answer_counts a
    ON u.assessment_answer_id = a.id
WHERE a.answer_table_rows > 1;