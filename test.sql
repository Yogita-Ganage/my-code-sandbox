
name-only organisation join one-to-many

WIP505044
   ↓
AHRD 1 row
customer_id   = 167197
customer_name = Ecclesiastical
   ↓
silver_wip_organisation
name = Ecclesiastical
   ↓
2 rows:
163008
163010




SELECT
    contr_id,
    contr_name,
    contr_src_id,
    contr_src_name
FROM silver_contract
WHERE LOWER(TRIM(contr_name)) = 'wip ecclesiastical';