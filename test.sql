json(
'[
  {
    "type":"TextBlock",
    "text":"RDM Controlled Delete Tool",
    "weight":"Bolder",
    "spacing":"Small"
  },
  {
    "type":"Input.ChoiceSet",
    "id":"deleteMethod",
    "label":"Delete Method",
    "style":"expanded",
    "isRequired":true,
    "spacing":"Small",
    "choices":[
      {
        "title":"Delete by Date",
        "value":"DATE"
      },
      {
        "title":"Delete by Instance(s)",
        "value":"INSTANCE"
      }
    ]
  },
  {
    "type":"Input.Date",
    "id":"deleteDate",
    "label":"Date",
    "spacing":"Small"
  },
  {
    "type":"TextBlock",
    "text":"Select Instance(s)",
    "weight":"Bolder",
    "spacing":"Small"
  }
]'
)