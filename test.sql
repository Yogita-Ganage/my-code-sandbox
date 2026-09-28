CProd Source Name
Updated the SONE cprod_src_name logic as per the revised definition. The source name is now derived using rota_type combined with the associated appointment flag descriptions from SR Mapping, with multiple flags aggregated in alphabetical order. Validated the expected example and confirmed the output is correct with no duplicate records introduced by the join.

CProd Source ID
Updated the SONE cprod_src_id logic in line with the revised Care Product definition. As there is no single stable Care Product source ID available for the SONE combination, the ID is derived using the system instance and the same rota_type + appointment flag combination used for cprod_src_name. Validation confirmed the generated IDs are unique with no duplicates.