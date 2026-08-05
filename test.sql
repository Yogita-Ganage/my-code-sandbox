SELECT
    u.id AS user_id,
    ten.client_type,
    rserv.service_src_name,
    rserv.service_id,
    COUNT(*) AS match_count
FROM silver_drj_users u

LEFT JOIN silver_drj_tenancies ten
    ON ten.id = u.tenancy_id

LEFT JOIN silver_rdm_service rserv
    ON rserv.src_sys_inst_id = 'MPB001'
   AND TRIM(LOWER(rserv.service_src_name))
       = TRIM(LOWER(ten.client_type))

WHERE u.profile_type = 'user'
  AND u.id = '9a1f508e-9624-43c5-86ff-7ebc5d8d289e'

GROUP BY
    u.id,
    ten.client_type,
    rserv.service_src_name,
    rserv.service_id;