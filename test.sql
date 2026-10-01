%%sql

-- 1. Backup silver_drj_assessment_results
DROP TABLE IF EXISTS test_backup_silver_drj_assessment_results;

CREATE TABLE test_backup_silver_drj_assessment_results AS
SELECT *
FROM silver_drj_assessment_results;


-- 2. Backup silver_drj_assessment_result_for_answers
DROP TABLE IF EXISTS test_backup_silver_drj_assessment_result_for_answers;

CREATE TABLE test_backup_silver_drj_assessment_result_for_answers AS
SELECT *
FROM silver_drj_assessment_result_for_answers;


-- 3. Backup silver_drj_assessment_answers
DROP TABLE IF EXISTS test_backup_silver_drj_assessment_answers;

CREATE TABLE test_backup_silver_drj_assessment_answers AS
SELECT *
FROM silver_drj_assessment_answers;



SELECT
    'assessment_results' AS table_name,
    (SELECT COUNT(*) FROM silver_drj_assessment_results) AS original_count,
    (SELECT COUNT(*) FROM test_backup_silver_drj_assessment_results) AS backup_count

UNION ALL

SELECT
    'assessment_result_for_answers',
    (SELECT COUNT(*) FROM silver_drj_assessment_result_for_answers),
    (SELECT COUNT(*) FROM test_backup_silver_drj_assessment_result_for_answers)

UNION ALL

SELECT
    'assessment_answers',
    (SELECT COUNT(*) FROM silver_drj_assessment_answers),
    (SELECT COUNT(*) FROM test_backup_silver_drj_assessment_answers);