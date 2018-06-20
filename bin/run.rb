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

  def display_demographic_options(most_or_least)
    puts ""
    puts Rainbow("Please specify, if you want to search #{most_or_least} common incidents by SEX, AGE, ETHNICITY or RACE").blue
  end

  def display_selected_demographic_option(most_or_least)
    second_user_input = gets.chomp
    if Incident.column_names.include?(second_user_input)
      if (second_user_input != "age")

      else
        puts Incident.display_mostleast_agegroup(most_or_least)
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
    puts Rainbow("To view all the reasons for a specific district please type one of the following district names: \n1D, 2D, 3D, 4D, 5D, 6D, 7D").blue
    user_location = gets.chomp
    user_location = user_location.upcase
    if Location.all.collect{|location|location.district}.include?(user_location) && user_location.class == String
      puts ""
      puts Rainbow("All of the incidents and frequencies for District #{user_location}").blue
      selected_location = Location.find_by(district: user_location)
      puts selected_location.parsed_get_all_reasons
    else
      puts Rainbow("Did not recognize location.").blue
    end
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
        puts Incident.parsed_most_common_hour
      when 3
        display_demographic_options("most")
        display_selected_demographic_option("most")
      when 4
        display_demographic_options("least")
        display_selected_demographic_option("least")
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
      #---REFACTOR THIS TO IT'S OWN METHOD: #continue_or_not
      puts Rainbow("Do you want to search again? (Y/N)").blue.bright
      continue = gets.chomp
      if continue[0].upcase == "Y"
        get_options
        user_input = gets.chomp.to_i
      elsif continue[0].upcase == "N"
        break
      else
        puts Rainbow("I didn't understand that, but here are our query options again").blue
        get_options
        user_input = gets.chomp.to_i
      end
      #----#continue_or_not method ends
    end
    puts Rainbow("Goodbye!").blue.bright
  end
runner

  # def check_user_input
  #   while user_input.class != Integer
  #     ""
  #   end
  # end
