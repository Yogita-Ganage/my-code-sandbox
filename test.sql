SELECT
    an.id AS anamnesis_id,
    an.appointment_id,
    an.user_id,
    COUNT(*) AS matched_assessment_rows
FROM silver_drj_anamnesises an
LEFT JOIN silver_drj_appointment_assessments aa
    ON an.appointment_id = aa.appointment_id
LEFT JOIN silver_drj_assessment_results ar
    ON aa.assessment_id = ar.assessment_id
   AND an.user_id = ar.user_id
GROUP BY
    an.id,
    an.appointment_id,
    an.user_id
HAVING COUNT(*) > 1
ORDER BY matched_assessment_rows DESC;



SELECT
    COUNT(*) AS joined_rows,
    COUNT(DISTINCT an.id) AS distinct_anamnesis_rows
FROM silver_drj_anamnesises an
LEFT JOIN silver_drj_appointment_assessments aa
    ON an.appointment_id = aa.appointment_id
LEFT JOIN silver_drj_assessment_results ar
    ON aa.assessment_id = ar.assessment_id
   AND an.user_id = ar.user_id;