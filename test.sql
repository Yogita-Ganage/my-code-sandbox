concat(
  outputs('Compose_-_Selected_RDM_Config')?['[instance_filter_column]'],
  ' eq ''',
  replace(string(item()),'''',''''''),
  ''''
)