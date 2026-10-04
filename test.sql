concat(
  'Created ge datetime''',
  convertTimeZone(
    concat(variables('varDeleteDate'),'T00:00:00'),
    'GMT Standard Time',
    'UTC',
    'yyyy-MM-ddTHH:mm:ssZ'
  ),
  ''' and Created lt datetime''',
  convertTimeZone(
    concat(
      formatDateTime(addDays(variables('varDeleteDate'),1),'yyyy-MM-dd'),
      'T00:00:00'
    ),
    'GMT Standard Time',
    'UTC',
    'yyyy-MM-ddTHH:mm:ssZ'
  ),
  ''''
)