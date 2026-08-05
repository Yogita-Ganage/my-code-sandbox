SELECT
    u.id AS user_id,
    u.tenancy_id,
    CONCAT('MPB', ten.id) AS expected_contr_id,
    con.contr_id,
    COUNT(*) AS contract_row_count
FROM silver_drj_users u
LEFT JOIN silver_drj_tenancies ten
    ON ten.id = u.tenancy_id
LEFT JOIN silver_contract con
    ON con.contr_id = CONCAT('MPB', ten.id)
WHERE u.profile_type = 'user'
  AND u.id = '9a1f508e-9624-43c5-86ff-7ebc5d8d289e'
GROUP BY
    u.id,
    u.tenancy_id,
    CONCAT('MPB', ten.id),
    con.contr_id;