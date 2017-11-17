require 'akamai_alerts/alert'

class AlertEdgeStatusCodes < Alert
  ALERT_TEMPLATE = JSON.parse(<<~EOS)
    {
      "definitionId": "",
      "origin": "STATIC",
      "fields": {
        "visibility": "all",
        "alertLowerBound": 50,
        "alertHttp": [
        ],
        "paramName": "cpercent",
        "templateId": "s@43",
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
      },
      "services": "all"
    }
  EOS

  def initialize(name, cpcodes, alert_status_codes, min_req, threshold, is_sum, emails)
    super(name, cpcodes, min_req, threshold, is_sum, emails)

    @definition['fields']['alertHttp'] = [alert_status_codes].flatten.map(&:to_s)
  end
end