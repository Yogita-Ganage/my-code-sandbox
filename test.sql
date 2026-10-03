concat(
'{"type":"AdaptiveCard","$schema":"http://adaptivecards.io/schemas/adaptive-card.json","version":"1.4","body":[{"type":"TextBlock","text":"RDM Controlled Delete Tool","weight":"Bolder","size":"Medium"},{"type":"TextBlock","text":"Select Source System","wrap":true},{"type":"Input.ChoiceSet","id":"sourceSystem","style":"compact","isMultiSelect":false,"placeholder":"Choose a Source System","choices":',
string(
    union(
        body('Select_-_Source_System_Choices'),
        body('Select_-_Source_System_Choices')
    )
),
'}],"actions":[{"type":"Action.Submit","title":"Continue"}]}'
)