class Incident < ActiveRecord::Base
  belongs_to :reason
  belongs_to :location

  def self.average_age
    age = self.where("age > 0").average(:age).round
    "Average age for persons of stop and frisk incidents is: #{age}"
  end

  def self.get_incident_hour_freq
    all_hours = self.all.collect{|incident| incident.date.hour}
    all_hours.each_with_object(Hash.new(0)) {|hour, hash| hash[hour] += 1 }
  end

  def self.most_common_hour
    hour_frequencies = self.get_incident_hour_freq
    hour_frequencies.key(hour_frequencies.values.max)
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

  def self.sort_reasons_by_gender(sex)
    arr = self.where("sex = ?", sex).group(:reason).count.sort_by{|k,v| v}.reverse
    arr.collect {|arr| "#{arr[0].description} with #{arr[1]} incidents"}
  end

end
