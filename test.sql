if(
  empty(outputs('Compose_-_Selected_Instance_String')),
  json('[]'),
  split(outputs('Compose_-_Selected_Instance_String'), ',')
)