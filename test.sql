SELECT DISTINCT
    af.flag,
    m.id,
    m.id_mapping_group,
    m.mapping,
    af.id_organisation_source
FROM silver_sone_srappointmentflags af
LEFT JOIN silver_sone_srmapping m
    ON af.flag = m.id
    AND af.id_organisation_source = m.id_organisation_source
WHERE af.flag IS NOT NULL
LIMIT 50;


SELECT DISTINCT
    af.flag,
    m.id,
    m.id_mapping_group,
    m.mapping,
    af.id_organisation_source
FROM silver_sone_srappointmentflags af
LEFT JOIN silver_sone_srmapping m
    ON af.flag = m.id_mapping_group
    AND af.id_organisation_source = m.id_organisation_source
WHERE af.flag IS NOT NULL
LIMIT 50;