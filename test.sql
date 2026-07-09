Validated the reported SONE session_patient_id examples against current silver_sessions and source SONE appointment/referral tables.

Both reported sessions now return the expected patient ID: SONEG4B9E66173613.

Also checked appointment vs referral patient ID mismatch for SONE and no mismatches were found in current source output.

No code change required based on current validation. This appears to be stale UAT output / data before the latest refresh.