if(
  equals(
    outputs('Compose_-_Selected_RDM_Config')?['[instance_filter_type]'],
    'LOOKUP'
  ),
  string(item()?['InstanceLookupID']),
  item()?['InstanceSourceID']
)