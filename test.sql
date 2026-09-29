Investigated the NULL values in care_epi_completion_status_conformed for MPB. The NULLs were caused by care episodes with no matching sessions, so no record was created in the completion status staging table and the LEFT JOIN returned NULL. Eve confirmed that these cases should default to 0. Updated the Care Episode logic using COALESCE and validated that the completion status now returns only 0 or 1 with no NULL values.


-- Default completion status to 0 when no matching completion-status staging record exists, as confirmed by Eve.