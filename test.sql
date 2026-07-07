Investigated cprod_src_name / session_cprod_id for WIP.

The required source values are available in the WIP source tables, but the UAT example rows have asv.is_primary = false. The existing Care Product ADD logic filters only asv.is_primary = true, so these care product combinations were excluded from the RDM ADD output.

Tested by removing the asv.is_primary filter in a test ADD table. WIP care product combinations increased from 331 to 773 with no blank cprod_name or cprod_src_id values. The UAT examples are now included in the ADD output.

Next change: remove the asv.is_primary = true filter from the WIP Care Product ADD logic. End-to-end session_cprod_id validation will be pending until the new RDM values are pushed through SharePoint/Dataflow.