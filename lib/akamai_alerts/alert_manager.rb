require 'akamai/edgegrid'
require 'net/http'
require 'uri'
require 'json'
require 'cgi'
require 'csv'

class AlertManager
  def initialize(edgerc = '~/.edgerc', section = 'default')
    @http = Akamai::Edgegrid::HTTP.new(get_host(edgerc, section), 443)
    @http.setup_from_edgerc(section: section)
    @baseuri = URI('https://' + @http.host)
  end

  def list_alert_definitions_in_csv
    response = @http.request(Net::HTTP::Get.new(URI.join(@baseuri.to_s, 'alerts/v2/alert-definitions').to_s))

    case response
      when Net::HTTPOK
        csv_string = CSV.generate(col_sep: "\t") do |csv|
          csv << %w(Name Threshold MinReq CPcodes Email)
          JSON.load(response.body)['data'].each do |alert|
            if alert['fields']['aca_cpcode']
              csv << [alert['fields']['name'], alert['fields']['param'], alert['fields']['alertLowerBound'], alert['fields']['aca_cpcode'].join(', '), alert['fields']['email'].join(', ')]
            end
          end
        end
      else
        raise "#{response.code} #{response.message}"
    end

    csv_string
  end

  def list_alert_definition_ids
    response = @http.request(Net::HTTP::Get.new(URI.join(@baseuri.to_s, 'alerts/v2/alert-definitions').to_s))

    case response
      when Net::HTTPOK
        JSON.load(response.body)['data'].map {|d| d['definitionId']}
      else
        raise "#{response.code} #{response.message}"
    end
  end

  def get_alert_definition(definition_id)
    response = @http.request(Net::HTTP::Get.new(URI.join(@baseuri.to_s, "alerts/v2/alert-definitions/#{definition_id}").to_s))

    case response
      when Net::HTTPOK
        JSON.load(response.body)
      else
        raise "#{response.code} #{response.message}"
    end
  end

  def create_alert(alert_definition)
    request = Net::HTTP::Post.new(URI.join(@baseuri.to_s, 'alerts/v2/alert-definitions').to_s, 'Content-Type' => 'application/json')
    request.body = alert_definition.to_json
    response = @http.request(request)

    case response
      when Net::HTTPCreated
        JSON.load(response.body)
      else
        raise "#{response.code} #{response.message}"
    end
  end

  def delete_alert(definition_id)
    response = @http.request(Net::HTTP::Delete.new(URI.join(@baseuri.to_s, "alerts/v2/alert-definitions/#{definition_id}").to_s))

    case response
      when Net::HTTPNoContent
      else
        raise "#{response.code} #{response.message}"
    end
  end
end
