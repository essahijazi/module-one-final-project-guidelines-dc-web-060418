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

  def self.parsed_most_common_hour
    hour = self.most_common_hour
    "#{hour}:00 is the time that encountered the most incidents."
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

  def self.sort_reasons_by_location
    location_arr = self.get_sorted("location")
    location_arr.collect do |arr|
      if arr[0].district != nil
        "District #{arr[0].district} has #{arr[1]} incidents"
      else
        "#{arr[1]} incidents occured at an 'Unknown' district location"
      end
    end
  end


  def self.parsed_mostleast_common_age_for_all_incidents(most_or_least)
    most_or_least == "most" ? age = self.get_sorted("age")[1][0] : age = self.least_common("age")[0]
    "#{age}yr olds were the age the with the #{most_or_least} incidents"
  end

end
