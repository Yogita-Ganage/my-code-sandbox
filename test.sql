WITH test AS (
    SELECT DISTINCT
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
)

SELECT
    COUNT(*) AS total_rows,

    SUM(
        CASE
            WHEN NOT (current_full <=> definition_full)
            THEN 1 ELSE 0
        END
    ) AS full_mismatch_count,

    SUM(
        CASE
            WHEN NOT (current_form_src_name <=> definition_form_src_name)
            THEN 1 ELSE 0
        END
    ) AS form_src_name_mismatch_count

FROM test;