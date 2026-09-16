-- Prefer active record (removed_data = 0) when duplicate source sessions exist
FROM (
    SELECT * FROM (
        SELECT *, ROW_NUMBER() OVER (
            PARTITION BY id_organisation_source, id
            ORDER BY COALESCE(removed_data, 2)
        ) rn
        FROM silver_sone_srappointment
    ) x WHERE rn = 1
) sra


Hi Sean, I found that most of the remaining duplicates are coming from the source where the same session has both RemovedData = 0 and RemovedData = 1.

There are two possible options:

Filter to RemovedData = 0, but I wouldn’t recommend this because if a session only has a removed record, we would lose it completely.
Use ROW_NUMBER() to prefer the active record (RemovedData = 0), but still keep the removed record if that is the only one available.

I think the second option is safer.