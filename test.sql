join(
  body('Select_-_lookup_filter_clauses'),
  ' or '
)if(
  equals(
    outputs('Compose_-_Selected_RDM_Config')?['[instance_filter_type]'],
    'LOOKUP'
  ),
  string(
    item()?[outputs('Compose_-_Selected_RDM_Config')?['[lookup_column_name]']]?['Id']
  ),
  string(
    item()?[outputs('Compose_-_Selected_RDM_Config')?['[instance_filter_column]']]
  )
)