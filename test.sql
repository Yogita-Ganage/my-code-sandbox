-- MPB clinical scores are care-episode scoped; no direct session link, so keep session_id null.
CAST(NULL AS STRING) AS form_ans_session_id


Although SESSION records exist for MPB, the MPB clinical score/questionnaire records are not directly session-scoped. The attribute definition says to use the session id only when it is available from the source and can be validated against the same care episode. For these MPB records, the legacy date-window match was only an inferred link, and Eve confirmed they should remain care-episode scoped. Therefore form_ans_session_id is set to NULL.