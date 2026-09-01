SELECT *
FROM silver_sone_srconfigurelistoption
WHERE LOWER(configured_list_option) LIKE '%initial consultation f2f%'
   OR LOWER(configured_list_option) LIKE '%initial consultation remote%'
   OR LOWER(configured_list_option) LIKE '%face to face%'
   OR LOWER(configured_list_option) LIKE '%telephone%'
   OR LOWER(configured_list_option) LIKE '%video%';



SELECT *
FROM silver_sone_srmapping
WHERE LOWER(mapping) LIKE '%face%'
   OR LOWER(mapping) LIKE '%telephone%'
   OR LOWER(mapping) LIKE '%video%'
   OR LOWER(mapping) LIKE '%f2f%'
   OR LOWER(mapping) LIKE '%remote%';