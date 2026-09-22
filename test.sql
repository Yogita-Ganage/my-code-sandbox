SELECT DISTINCT
    id,
    name,
    service_line,
    invoice_prefix
FROM silver.silver_drj_tenancies
WHERE name IS NOT NULL;