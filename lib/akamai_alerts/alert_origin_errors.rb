require 'akamai_alerts/alert'

class AlertOriginErrors < Alert
  ALERT_TEMPLATE = JSON.parse(<<~EOS)
    {
      "definitionId": "",
      "origin": "STATIC",
      "fields": {
        "visibility": "all",
        "alertLowerBound": 5,
        "paramName": "cpercent",
        "templateId": "s@9",
        "aca_cpcode": [
        ],
        "network": "both",
        "emailHtmlFormat": false,
        "param": 2.0,
        "name": "",
        "isSum": true,
        "email": [
        ],
        "emailBrief": [],
        "definitionId": "",
        "origVisibility": "all"
      }
    }
  EOS

  def initialize(name, cpcodes, min_req, threshold, is_sum, emails)
    super
  end
end