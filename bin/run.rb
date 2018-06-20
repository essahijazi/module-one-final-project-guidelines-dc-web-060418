require_relative '../config/environment.rb'


  def welcome
    puts "Welcome! Please select ONE NUMBER from questions below"
  end

  def get_options
    puts Rainbow("What would you like to know about stop and frisk incidents in Washington, DC?").blue.bright
    puts ""
    puts Rainbow("1. What was the average age of people stopped and frisked?").blue
    puts Rainbow("2. What hour of the day had the most stops?").blue
    puts Rainbow("3. What demographic groups were MOST likely to be stopped?").blue
    puts Rainbow("4. What demographic groups were LEAST likely to be stopped?").blue
    puts Rainbow("5. What reasons were most common to stop and frisk incidents, by gender").blue
    puts Rainbow("6. Locations").blue
    puts Rainbow("7. Exit").red
    puts ""
  end


  def get_attributes(value)
    puts ""
    puts Rainbow("Please specify, if you want to search #{value} common incidents by SEX, AGE, ETHNICITY or RACE").blue
    second_user_input = gets.chomp
    if Incident.column_names.include?(second_user_input)
      if value == "most"
        puts Incident.most_common(second_user_input)
      elsif value == "least"
        puts Incident.least_common(second_user_input)
      end
    else
      puts Rainbow("Sorry, that's not a column in our table.").blue
    end
  end

  def get_gender
    puts ""
    puts Rainbow("Please specify, if you want to collect reasons for stops for MALE or FEMALE").blue
    second_user_input = gets.chomp.downcase.capitalize
    if second_user_input == "Male" || second_user_input == "Female"
      puts Incident.sort_reasons_by_gender(second_user_input)
    else
      puts Rainbow("Sorry, you have to choose 'male' or 'female'").blue
    end
  end


  def get_reasons_for_location
    puts Rainbow("To view all the reasons for a specific district please type one of the following district names: 1D, 2D, 3D, 4D, 5D, 6D, 7D, Unknown").blue
    user_input = gets.chomp
    puts ""
    "All of the incidents and frequencies for District #{user_input}"
    selected_location = Location.find_by(district: user_input)
    puts selected_location.parsed_get_all_reasons
  end

  def runner
    welcome
    get_options

    user_input = gets.chomp.to_i

    while user_input != 7
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
      when 6
        puts Incident.sort_reasons_by_location
        puts ""
        get_reasons_for_location
      else
        puts "Sorry, that's not a valid number. Choose from our options between 1-7"
      end
      puts ""
      puts Rainbow("*****************************").yellow
      puts Rainbow("Do you want to search again?").blue.bright
      get_options
      user_input = gets.chomp.to_i
    end
    puts Rainbow("Goodbye!").blue.bright.blink
  end
runner

  # def check_user_input
  #   while user_input.class != Integer
  #     ""
  #   end
  # end
