Updated the SONE del_meth_src_name logic as per the revised definition.
The source name is now derived using the appointment rota_type combined with the associated appointment flag descriptions from SR Mapping. Multiple flags are aggregated in alphabetical order to avoid duplicate appointment rows.
Validated the definition example, nulls, row counts and duplicates. Results are as expected.



Updated the SONE del_meth_src_id logic in line with the revised Delivery Method Source Name definition.
As there is no single unique Delivery Method ID available in SONE, the ID is derived using the system instance and the same rota_type + appointment flag combination used for the source name.
Validation confirmed the generated IDs are unique with no duplicate del_meth_src_id values.