Before refresh:
60,230 missing-parent rows
+    69 duplicate expansion
=60,299 NULLs

After refresh:
39,992 missing-parent rows
+     0 extra
=39,992 NULLs



WITH unmatched AS (
    SELECT DISTINCT
        arans.assessment_result_id
    FROM silver_drj_assessment_result_for_answers arans
    LEFT JOIN silver_drj_assessment_results ar
        ON arans.assessment_result_id = ar.id
    WHERE ar.id IS NULL
)

SELECT
    COUNT(*) AS unmatched_ids,

    SUM(CASE WHEN b.id IS NOT NULL THEN 1 ELSE 0 END) AS found_in_bronze,

    SUM(CASE WHEN b.id IS NULL THEN 1 ELSE 0 END) AS not_found_in_bronze

FROM unmatched u

LEFT JOIN (
    SELECT DISTINCT id
    FROM bronze_drj_assessmentresults
) b
    ON u.assessment_result_id = b.id;