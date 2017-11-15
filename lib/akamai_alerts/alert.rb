require 'json'

class Alert
  ALERT_TEMPLATE = nil

  def initialize(name, cpcodes, min_req, threshold, is_sum, emails)
    raise 'Alert is an abstract class' if self.class::ALERT_TEMPLATE.nil?

    @definition = self.class::ALERT_TEMPLATE.dup
    @definition['name'] = name
    @definition['fields']['aca_cpcode'] = [cpcodes].flatten.map(&:to_s)
    @definition['fields']['alertLowerBound'] = min_req
    @definition['fields']['param'] = threshold
    @definition['fields']['isSum'] = is_sum
    @definition['fields']['email'] = [emails].flatten
  end

  def to_json
    @definition.to_json
  end
end