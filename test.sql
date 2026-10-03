concat(
  outputs('Compose_-_Selected_RDM_Config')?['[instance_filter_column]'],
  ' eq ',
  decodeUriComponent('%27'),
  item()?['InstanceSourceID'],
  decodeUriComponent('%27')
)