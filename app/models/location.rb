class Location < ActiveRecord::Base
  has_many :incidents
  has_many :reasons, through: :incidents



  def get_all_reasons
    Incident.where(location: self).group(:reason).count.sort_by{|k, v| v}.reverse
  end

  def get_most_common_reason
    self.get_all_reasons.first
  end

  def parsed_get_all_reasons
    all_reasons = self.get_all_reasons
    all_reasons.collect {|arr| "#{arr[0].description} with #{arr[1]} incidents"}
  end

end
