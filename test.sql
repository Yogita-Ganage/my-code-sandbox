concat(
  outputs('Compose_-_Selected_RDM_Config')?['[lookup_column_name]'],
  'Id eq ',
  string(item())
)