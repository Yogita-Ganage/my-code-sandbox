WITH base AS (
    SELECT
        arans.assessment_result_id,
        arans.assessment_answer_id
    FROM silver_drj_assessment_result_for_answers arans
),

-- Actual first join in the Form Answer code
s1 AS (
    SELECT
        b.*,
        asmans.assessment_question_id
    FROM base b
    LEFT JOIN silver_drj_assessment_answers asmans
        ON asmans.id = b.assessment_answer_id
),

-- assessment_results: ar.user_id is used for form_ans_care_epi_id
s2 AS (
    SELECT
        s1.*,
        ar.id AS ar_id,
        ar.user_id AS ar_user_id,
        ar.assessment_id AS ar_assessment_id
    FROM s1
    LEFT JOIN silver_drj_assessment_results ar
        ON s1.assessment_result_id = ar.id
),

s3 AS (
    SELECT
        s2.*,
        appt.id AS appt_id,
        appt.user_id AS appt_user_id
    FROM s2
    LEFT JOIN silver_drj_appointments appt
        ON s2.ar_user_id = appt.user_id
),

s4 AS (
    SELECT
        s3.*,
        aa.id AS aa_id
    FROM s3
    LEFT JOIN silver_drj_appointment_assessments aa
        ON aa.id = s3.appt_id
       AND aa.assessment_id = s3.ar_assessment_id
),

s5 AS (
    SELECT
        s4.*,
        users.id AS users_id
    FROM s4
    LEFT JOIN silver_drj_users users
        ON s4.appt_user_id = users.id
),

s6 AS (
    SELECT
        s5.*,
        asmq.id AS asmq_id
    FROM s5
    LEFT JOIN silver_drj_assessment_questions asmq
        ON asmq.id = s5.assessment_question_id
),

s7 AS (
    SELECT
        s6.*,
        asmt.id AS asmt_id
    FROM s6
    LEFT JOIN silver_drj_assessments asmt
        ON asmt.id = s6.ar_assessment_id
),

s8 AS (
    SELECT
        s7.*
    FROM s7
    LEFT JOIN silver_rdm_form_question rdmfq
        ON TRIM(LOWER(rdmfq.form_ques_src_id))
         = TRIM(LOWER(CONCAT('MPB001_', CAST(s7.asmt_id AS STRING))))
)

SELECT '01 - AR join only' AS step, COUNT(*) AS null_rows
FROM silver_drj_assessment_result_for_answers arans
LEFT JOIN silver_drj_assessment_results ar
    ON arans.assessment_result_id = ar.id
WHERE ar.id IS NULL

UNION ALL

SELECT '02 - + assessment_answers', COUNT(*)
FROM s2
WHERE ar_id IS NULL

UNION ALL

SELECT '03 - + appointments', COUNT(*)
FROM s3
WHERE ar_id IS NULL

UNION ALL

SELECT '04 - + appointment_assessments', COUNT(*)
FROM s4
WHERE ar_id IS NULL

UNION ALL

SELECT '05 - + users', COUNT(*)
FROM s5
WHERE ar_id IS NULL

UNION ALL

SELECT '06 - + assessment_questions', COUNT(*)
FROM s6
WHERE ar_id IS NULL

UNION ALL

SELECT '07 - + assessments', COUNT(*)
FROM s7
WHERE ar_id IS NULL

UNION ALL

SELECT '08 - + rdm_form_question', COUNT(*)
FROM s8
WHERE ar_id IS NULL;