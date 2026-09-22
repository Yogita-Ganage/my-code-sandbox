Reworked MPB service_src_name and service_src_id following the updated definition.
Updated the logic to use service_line instead of invoice_prefix.
service_src_name now returns the MPB service line, and service_src_id is derived as MPB001 - <service_line>.
Confirmed with Eve to use service_line for the ID as well.
Validation completed and the output is now at service-line level rather than tenancy level.