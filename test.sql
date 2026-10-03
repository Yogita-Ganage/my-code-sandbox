{
  "type": "AdaptiveCard",
  "version": "1.4",
  "body": [
    {
      "type": "TextBlock",
      "text": "Select Date",
      "weight": "Bolder",
      "size": "Medium"
    },
    {
      "type": "Input.Date",
      "id": "deleteDate",
      "label": "Date",
      "isRequired": true
    }
  ],
  "actions": [
    {
      "type": "Action.Submit",
      "title": "Continue"
    }
  ]
}