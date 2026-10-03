{
  "type": "AdaptiveCard",
  "version": "1.4",
  "body": [
    {
      "type": "TextBlock",
      "text": "Select Delete Method",
      "weight": "Bolder",
      "size": "Medium"
    },
    {
      "type": "Input.ChoiceSet",
      "id": "deleteMethod",
      "style": "expanded",
      "isRequired": true,
      "choices": [
        {
          "title": "Delete by Date",
          "value": "DATE"
        },
        {
          "title": "Delete by Instance(s)",
          "value": "INSTANCE"
        }
      ]
    }
  ],
  "actions": [
    {
      "type": "Action.Submit",
      "title": "Continue"
    }
  ]
}