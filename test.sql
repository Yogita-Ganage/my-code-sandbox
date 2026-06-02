LEFT JOIN temp_wip_form_answer_parsed_date_lookup pdl
    ON pdl.activity_header_id = s.activity_header_id
   AND pdl.group_id = s.group_id
   AND TRIM(LOWER(pdl.group_desc)) = TRIM(LOWER(s.group_desc))