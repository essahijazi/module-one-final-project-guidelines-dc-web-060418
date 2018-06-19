require_relative '../config/environment.rb'


  def welcome
    puts "Wecome! Please select ONE of the following options by typing the corresponding number"
  end

  def get_options
    puts "Queries:"

    puts "1. Average age of 'Person'"
    puts "2. Hour of day with most Stop & Frisks"
    puts "3. Most common... "
    puts "4. Least common... "
    puts "5. Most common reason for Male/Female"
    puts "6. Exit"
  end


  def get_attributes
    puts "Please specify, if you want to search by SEX, AGE, ETHNICITY, RACE"

    user_input = gets.chomp.to_s.downcase!
    puts Incident.most_common(user_input)
  end


  def runner
    welcome
    get_options

    user_input = gets.chomp.to_i

    while user_input != 6
      case user_input
      when 1
        puts Incident.average_age
      when 2
        puts Incident.most_common_hour
      when 3
        get_attributes
      when 4

      when 5

      when 6

      else
        puts "Oh No!"
      end
      user_input = gets.chomp.to_i
    end




  end
runner

  # def check_user_input
  #   while user_input.class != Integer
  #     ""
  #   end
  # end
