Investigated the MPB session_src_id UAT failure. The duplicate was caused by multiple records in silver_drj_appointment_financials for the same appointment with different billed_fee_amount values. Updated the financial join to keep one record per appointment, prioritising the non-null billed fee value.  
Updated MPB session_src_id to use the source Appointment ID only, removing the MPB prefix as per the revised definition.  
Validation: Duplicate check now returns 0.  
Note: session_cost logic can be reviewed again once its definition is finalised.
