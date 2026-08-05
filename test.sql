SELECT
    u.id AS user_id,
    u.tenancy_id,
    ten.id AS tenancy_id,
    rdmc.contr_src_id,
    rdmc.contr_id,
    COUNT(*) OVER (
        PARTITION BY rdmc.contr_src_sys_inst_src_id, rdmc.contr_src_id
    ) AS contract_match_count
FROM silver_drj_users u
LEFT JOIN silver_drj_tenancies ten
    ON ten.id = u.tenancy_id
LEFT JOIN silver_rdm_contract rdmc
    ON rdmc.contr_src_sys_inst_src_id = 'MPB001'
   AND CAST(rdmc.contr_src_id AS VARCHAR(100))
       = CAST(ten.id AS VARCHAR(100))
WHERE u.profile_type = 'user'
  AND u.id = '9a1f508e-9624-43c5-86ff-7ebc5d8d289e';