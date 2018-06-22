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
    all_reasons.collect.with_index {|arr, i| "#{i+1}. #{arr[0].description} with #{arr[1]} incidents"}
  end

  def get_my_incidents(reason_id)
    cases = Incident.where(location: self).where(reason_id: reason_id)
    cases.collect do |incident|
      #calling helper method for parsing incidents' information to a string
      incident.parse
    end
  end

end
