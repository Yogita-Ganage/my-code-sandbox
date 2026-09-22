SELECT
    id,
    id_mapping_group,
    mapping,
    id_organisation_source
FROM silver_sone_srmapping
WHERE LOWER(mapping) LIKE '%walk%'
   OR LOWER(mapping) LIKE '%follow%'
   OR LOWER(mapping) LIKE '%telephone%';