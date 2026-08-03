Root cause identified: The WIP completion status join was using CONCAT('WIP', ah.file_number), while session_care_epi_id in the sessions/staging table is created using the WIP001 prefix. This caused the completion status values not to map and return as null.

Updated the join to: CONCAT('WIP001', ah.file_number)


Validated in PROD using a test table. The completion status now maps correctly and returns both 0 and 1 values as per the existing definition.