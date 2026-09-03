,rdmdelmeth.del_meth_id AS session_del_meth_id



LEFT JOIN silver_rdm_delivery_method rdmdelmeth
    ON LOWER(TRIM(rdmdelmeth.del_meth_src_id))
       = LOWER(TRIM(
           CONCAT(
               'WIP001_',
               CAST(SerT.id AS STRING),
               '_',
               CAST(srv.id AS STRING),
               '_',
               CAST(atyp.id AS STRING)
           )
       ))