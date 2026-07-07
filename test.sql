Investigated session_cprod_id for WIP.

session_cprod_id is dependent on Care Product RDM values generated from cprod_src_name / cprod_src_id. The UAT examples are blank because the required WIP care product combinations were excluded from the Care Product ADD logic due to the asv.is_primary = true filter.

Validated the source data and confirmed the required service type, service activity and activity type values are available. Tested by removing the asv.is_primary filter in a test ADD table. WIP care product combinations increased from 331 to 773 with no blank cprod_name or cprod_src_id values.

Next change is to remove the asv.is_primary = true filter from the WIP Care Product ADD logic. End-to-end validation of session_cprod_id will be pending until the new RDM values are pushed through SharePoint/Dataflow and available in silver_rdm_care_product.