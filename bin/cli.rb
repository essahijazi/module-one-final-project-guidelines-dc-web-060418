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
  puts Rainbow("6. Search by locations").blue
  puts Rainbow("7. Do your own search").blue
  puts Rainbow("8. Exit").red
  puts ""
end

def display_demographic_options(most_or_least)
  puts ""
  puts Rainbow("Please specify, if you want to search #{most_or_least} common incidents by SEX, AGE, ETHNICITY or RACE").blue
end

def display_selected_demographic_option(most_or_least)
  second_user_input = gets.chomp.downcase
  if Incident.column_names.include?(second_user_input)

    if (second_user_input != "age")
      puts Incident.display_mostleast_demographic_option(most_or_least, second_user_input)
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
    #ASK IF THEY WANT INCIDENT INFORMATION FOR ANY LIST ITEM.
    continue_with_location(selected_location)
  else
    puts Rainbow("Did not recognize location.").blue
  end
end

def get_and_answer_user_query(user_input)
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
  when 7
    user_search
  else
    puts "Sorry, that's not a valid number. Choose from our options between 1-7"
  end
  puts ""
  puts Rainbow("****************************************").blue
end

def continue?
  puts Rainbow("Do you want to search again? (Y/N)").blue.bright
  continue = gets.chomp
  if continue[0].upcase == "Y"
    return true
  elsif continue[0].upcase == "N"
    return false
  else
    puts Rainbow("I didn't understand that, but here are our query options again").blue
    return true
  end
end

def continue_with_location(selected_location)
  puts ""
  puts Rainbow("Do you want to get all information of any of these incidents?").blue
  puts Rainbow("Type in the NUMBER of the row of incidents you'd like to know more of.").blue
  user_number = gets.chomp.to_i
  if user_number > 0 && user_number <= selected_location.get_all_reasons.length
      #translate user's number to an index
      user_index = user_number-1
      #get the reason's ID 
      reason_id = selected_location.get_all_reasons[user_index].first.id
      #run the method to output all incidents with matching reason and location
      puts selected_location.get_my_incidents(reason_id)
  else
      puts Rainbow("Sorry, did not recognize list item number.").blue
  end
end

def user_search
  puts Rainbow("Enter your own search terms. You may specify a 'location', 'age', 'sex', 'ethnicity', 'race'").blue
  puts Rainbow("Example input: 'sex: male, race: white'").blue
  user_search = gets.chomp
  user_hash = Incident.hashify_user_search(user_search)
  if Incident.search_hash_is_correct?(user_hash)
    #do the search
    results = Incident.search_with_hash(user_hash)
    if results.empty?
      puts Rainbow("No matches.").blue
    else
      puts results
      #puts Incident.search_with_hash(user_hash)
    end
  else
    puts Rainbow("Sorry, those search terms didn't match our column names. Please check your search terms correctedness.").blue
  end
end

def runner
  welcome
  get_options
  user_input = gets.chomp.to_i

  while user_input != 8
    #give them the answer they were looking for
    get_and_answer_user_query(user_input)
    #ask if they want to query again. Evaluates Y/N to true or false
    if continue?
      get_options
      user_input = gets.chomp.to_i
    else
      #if they answer no, break from loop and exit CLI
      break
    end
  end

  puts Rainbow("Goodbye!").blue.bright
end
