SELECT
    contr_src_name,
    contr_src_id,
    contr_id
FROM silver_rdm_contract
WHERE UPPER(TRIM(contr_src_name)) IN (
    'DERM COVENTRY',
    'PENNINE MSK',
    'MSK SEL',
    'DERM SEFTON',
    'B2C DERM',
    'DERM CALDERDALE'
)
ORDER BY contr_src_name;


SELECT
    contr_src_name,
    contr_src_id,
    contr_src_sys_inst_id
FROM silver_rdm_contract_add
WHERE UPPER(TRIM(contr_src_name)) IN (
    'DERM COVENTRY',
    'PENNINE MSK',
    'MSK SEL',
    'DERM SEFTON',
    'B2C DERM',
    'DERM CALDERDALE'
)
ORDER BY contr_src_name;