require_relative '../config/environment.rb'


  def welcome
    puts "Welcome! Please select ONE of the following options by typing the corresponding number"
  end

  def get_options
    puts "Queries:" #What would you like to know about stop and frisk incidents in Washington, DC?

    puts "1. Average age of 'Person'" #What was the average age of people stopped and frisked?
    puts "2. Hour of day with most Stop & Frisks" #At what time did the most incidents occur?
    puts "3. Most common... "
    puts "4. Least common... "
    puts "5. List reasons and frequencies for stop and frisks by gender"
    puts "6. Exit"
  end


  def get_attributes(value)
    puts "Please specify, if you want to search #{value} common incidents by SEX, AGE, ETHNICITY or RACE"
    second_user_input = gets.chomp
    if Incident.column_names.include?(second_user_input)
      if value == "most"
        puts Incident.most_common(second_user_input)
      elsif value == "least"
        puts Incident.least_common(second_user_input)
      end
    else
      puts "Sorry, that's not a column in our table."
    end
  end

  def get_gender
    puts "Please specify, if you want to collect reasons for stops for MALE or FEMALE"
    second_user_input = gets.chomp.downcase.capitalize
    if second_user_input == "Male" || second_user_input == "Female"
      puts Incident.sort_reasons_by_gender(second_user_input)
    else
      puts "Sorry, you have to choose 'male' or 'female'"
    end
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
        get_attributes("most")
      when 4
        get_attributes("least")
      when 5
        get_gender
      else
        puts "Oh No!"
      end
      puts ""
      puts "*****************************"
      puts "Do you want to search again?"
      get_options
      user_input = gets.chomp.to_i
    end
    puts "Goodbye!"
  end
runner

  # def check_user_input
  #   while user_input.class != Integer
  #     ""
  #   end
  # end
