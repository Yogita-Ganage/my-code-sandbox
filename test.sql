concat(
'{"type":"AdaptiveCard","$schema":"http://adaptivecards.io/schemas/adaptive-card.json","version":"1.4","body":[{"type":"TextBlock","text":"RDM Controlled Delete Tool","weight":"Bolder","size":"Medium"},{"type":"TextBlock","text":"Select RDM List","wrap":true},{"type":"Input.ChoiceSet","id":"rdmList","style":"compact","isMultiSelect":false,"placeholder":"Choose an RDM list","choices":',
string(body('Select_-_RDM_List_Choices')),
'}],"actions":[{"type":"Action.Submit","title":"Continue"}]}'
)