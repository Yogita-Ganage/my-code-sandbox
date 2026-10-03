json(
  concat(
    '{"type":"TextBlock","text":"',
    items('Apply_to_each')?['value'],
    '","weight":"Bolder","separator":false,"spacing":"Small"}'
  )
)