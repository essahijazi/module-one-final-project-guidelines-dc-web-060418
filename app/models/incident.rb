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
    most_or_least.downcase == "most" ? age = self.get_sorted("age")[1][0] : age = self.least_common("age")[0]
    "#{age}yr olds were the age the with the #{most_or_least} incidents"
  end


  def self.get_all_ages
    #[#<Incident:0x007fe713dc0eb8 id: nil, age: 22>,
    #<Incident:0x007fe713dc0d50 id: nil, age: 47>,
    #<Incident:0x007fe713dc0be8 id: nil, age: 21>]
    age_objects = Incident.select("age")

    #[22, 47, 21]
    age_array = age_objects.collect {|obj| obj.age}
  end


  # Returns an array of arrays in descending order of frequency
  # [[:"18-25", 35], [:"26-35", 32], [:"56+", 30], [:"36-45", 17], [:"46-55", 14]]
  def self.age_to_agegroups(age_array)
    age_hash = {}
    age_hash[:"18-25"] = 0
    age_hash[:"26-35"] = 0
    age_hash[:"36-45"] = 0
    age_hash[:"46-55"] = 0
    age_hash[:"56+"] = 0

    age_array.each do |age|
      if age >= 18 && age <= 25
        age_hash[:"18-25"] += 1
      elsif age >= 26 && age <= 35
        age_hash[:"26-35"] += 1
      elsif age >= 36 && age <= 45
        age_hash[:"36-45"] += 1
      elsif age >= 46 && age <= 55
        age_hash[:"46-55"] += 1
      else
        age_hash[:"56+"] += 1
      end
    end
    age_hash.sort_by {|key, value| value}.reverse
  end

  def self.get_mostleast_age_group(most_or_least)
    age_array = self.get_all_ages
    age_groups = self.age_to_agegroups(age_array)

    #returns the age group and its frequency
    #[:"18-25", 35]
    most_or_least == "most" ? age_groups.first : age_groups.last
  end

  def self.display_mostleast_agegroup(most_or_least)
    agegroup_freq = self.get_mostleast_age_group(most_or_least)

    agegroup = agegroup_freq[0].to_s
    freq = agegroup_freq[1]

    "The #{agegroup}yr old age group was the #{most_or_least} common age group and they had #{freq} incidents"

  end
end
