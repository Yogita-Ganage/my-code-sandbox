{
  "type": "AdaptiveCard",
  "version": "1.4",
  "body": [
    {
      "type": "TextBlock",
      "text": "Delete Options",
      "weight": "Bolder",
      "size": "Medium"
    },
    {
      "type": "Input.ChoiceSet",
      "id": "deleteType",
      "label": "Delete Type",
      "style": "expanded",
      "isRequired": true,
      "choices": [
        {
          "title": "All records for selected instance(s)",
          "value": "ALL"
        },
        {
          "title": "Selected instance(s) + specific date",
          "value": "DATE"
        }
      ]
    },
    {
      "type": "Input.Text",
      "id": "performedBy",
      "label": "Performed By",
      "placeholder": "Enter your name"
    },
    {
      "type": "Input.Text",
      "id": "reason",
      "label": "Reason",
      "placeholder": "Reason for deletion",
      "isMultiline": true
    }
  ],
  "actions": [
    {
      "type": "Action.Submit",
      "title": "Continue"
    }
  ]
}