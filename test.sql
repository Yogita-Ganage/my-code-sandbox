concat(
  '{"type":"AdaptiveCard","$schema":"http://adaptivecards.io/schemas/adaptive-card.json","version":"1.4","body":',
  string(variables('varInstanceCardBody')),
  ',"actions":[{"type":"Action.Submit","title":"Continue"}]}'
)