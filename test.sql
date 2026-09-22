UAT Rework:
Investigated the WIP z_src_is_active UAT failure. The issue was caused by an incorrect direct join between silver_wip_activityentry and silver_wip_service. Updated the logic to join via silver_wip_activityservice as per the source relationship.

Validation completed:

Both joins have 0 unmatched records.
3,834 distinct WIP care episodes are correctly identified as inactive.
No incorrectly flagged inactive records were found.
Sample records were validated against the expected “case raised in error” service descriptions.