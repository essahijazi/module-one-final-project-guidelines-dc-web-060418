class Incident < ActiveRecord::Base
  belongs_to :reason
  belongs_to :location



  def self.average_age
    self.where("age > 0").average(:age).round
  end


  def self.get_incident_hour_freq
    all_hours = self.all.collect{|incident| incident.date.hour}
    hour_frequencies = {}
    all_hours.each do |hour|
      if hour_frequencies.keys.include?(hour.to_s.to_sym)
        hour_frequencies[hour.to_s.to_sym] += 1
      else
        hour_frequencies[hour.to_s.to_sym] = 1
      end
    end
    hour_frequencies
  end

  def self.most_common_hour
    hour_frequencies = self.get_incident_hour_freq
    hour_frequencies.key(hour_frequencies.values.max).to_s.to_i
    # .max_by{|k, v| v} => [:"11" , 18]
    # .key(hour_frequencies.values.max).to_s.to_i => 11
  end


  def self.get_sorted(key)
     self.group(key).count.sort_by{|k,v| v}.reverse
  end


  def self.most_common(attribute)
      self.get_sorted(attribute).first
  end

  def self.least_common(attribute)
      self.get_sorted(attribute).last
  end



  def self.most_common_reason_for_sex(sex)
    self.where("sex = ?", sex).group(:reason).count.sort_by{|k,v| v}.reverse
  end

end
