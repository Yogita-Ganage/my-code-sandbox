json(
  concat(
    '{"type":"Input.ChoiceSet","id":"instances_',
    replace(items('Apply_to_each')?['value'],' ','_'),
    '","style":"expanded","isMultiSelect":true,"choices":',
    string(body('Select_-_Current_System_Instance_Choices')),
    '}'
  )
)