require 'akamai_alerts/alert'

class AlertEdgeErrors < Alert
  ALERT_TEMPLATE = JSON.parse(<<~EOS)
    {
      "definitionId": "",
      "origin": "STATIC",
      "fields": {
        "visibility": "all",
        "alertLowerBound": 50,
        "paramName": "cpercent",
        "templateId": "s@28",
        "aca_cpcode": [
        ],
        "network": "both",
        "emailHtmlFormat": false,
        "param": 20.0,
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