SELECT DISTINCT
    ty.id AS service_type_id,
    sg.id AS statistical_group_id,
    st.id AS statistical_type_id,

    ty.description AS service_type_desc,
    sg.description AS statistical_group_desc,
    st.description AS statistical_type_desc,

    CONCAT_WS(
        '_',
        ty.description,
        sg.description,
        st.description
    ) AS current_full,

    CONCAT(
        ty.description, '_',
        sg.description, '_',
        st.description
    ) AS definition_full,

    CONCAT_WS(
        '_',
        ty.description,
        sg.description
    ) AS current_form_src_name,

    CONCAT(
        ty.description, '_',
        sg.description
    ) AS definition_form_src_name

FROM silver_wip_statisticalgroup sg

LEFT JOIN silver_wip_statisticaltype st
    ON sg.id = st.statistical_group_id

LEFT JOIN silver_wip_statisticalchoice sc
    ON st.id = sc.statistical_type_id

LEFT JOIN silver_wip_statistic s
    ON sc.id = s.statistical_choice_id

LEFT JOIN silver_wip_activityheader ah
    ON s.activity_header_id = ah.id

LEFT JOIN silver_wip_servicetype ty
    ON ah.service_type_id = ty.id

WHERE ty.id IS NOT NULL
  AND sg.id IS NOT NULL
  AND st.id IS NOT NULL