require_relative '../config/environment.rb'

require_relative '../app/models/incident.rb'
require_relative '../app/models/reason.rb'
require_relative '../app/models/location.rb'
require_relative '../bin/cli.rb'
require 'bundler'

describe Incident do
    let(:incident) {Incident.first}





    it "knows its age" do
        expect(incident.age).to be 22
    end

    it "knows its ethnicity" do
        expect(incident.ethnicity).to eq "Not Hispanic Or Latino"
    end

    it "has method #sort_reasons_by_location that outputs array of string descriptions of locations and their incidents" do
        expect(Incident.sort_reasons_by_location).to eq(
            ["District 7D has 56 incidents",
            "District 3D has 24 incidents",
            "District 6D has 16 incidents",
            "District 1D has 13 incidents",
            "13 incidents occured at an 'Unknown' location",
            "District 5D has 3 incidents",
            "District 2D has 2 incidents",
            "District 4D has 1 incidents"])
    end

    #<------------------------OPTION 1 TESTS------------------------>
    it "knows average age for all incidents" do
        expect(Incident.average_age).to eq("Average age for persons of stop and frisk incidents is: 35")
    end

    #<------------------------OPTION 2 TESTS------------------------>
    it "has method #most_common_hour that returns most common hour for stop and frisks" do
        expect(Incident.most_common_hour).to be 11
    end

    #<------------------------OPTION 3 TESTS------------------------>
    it "Will display the 'most' common group within the 'sex' category" do
        expect(Incident.display_mostleast_demographic_option("most", "sex"))
        .to eq("94 out of 128 incidents were related with the Male group in the sex category")
    end

    it "Will display the 'most' common group within the 'ethnicity' category" do
        expect(Incident.display_mostleast_demographic_option("most", "ethnicity"))
        .to eq("91 out of 128 incidents were related with the Not Hispanic Or Latino group in the ethnicity category")
    end

    it "Will display the 'most' common group within the 'race' category" do
        expect(Incident.display_mostleast_demographic_option("most", "race"))
        .to eq("114 out of 128 incidents were related with the Black group in the race category")
    end

    it "Will display the 'most' common age group within the 'age' category" do
        expect(Incident.display_mostleast_agegroup("most"))
        .to eq("The 18-25yr old age group was the most common age group and they had 35 incidents")
    end

    #<------------------------OPTION 4 TESTS------------------------>
    it "Will display the 'least' common group within the 'sex' category" do
        expect(Incident.display_mostleast_demographic_option("least", "sex"))
        .to eq("33 out of 128 incidents were related with the Female group in the sex category")
    end

    it "Will display the 'least' common group within the 'ethnicity' category" do
        expect(Incident.display_mostleast_demographic_option("least", "ethnicity"))
        .to eq("1 out of 128 incidents were related with the Hispanic Or Latino group in the ethnicity category")
    end

    it "Will display the 'least' common group within the 'race' category" do
        expect(Incident.display_mostleast_demographic_option("least", "race"))
        .to eq("2 out of 128 incidents were related with the Asian group in the race category")
    end

    it "Will display the 'least' common age group within the 'age' category" do
        expect(Incident.display_mostleast_agegroup("least"))
        .to eq("The 46-55yr old age group was the least common age group and they had 14 incidents")
    end

    #<------------------------OPTION 5 TESTS------------------------>
    it "Display all of the reasons and their frequencies that are related with 'males' in the 'sex' category" do
      expect(Incident.sort_reasons_by_gender("Male")).to eq(
        ["Moving Violation with 29 incidents",
         "Suspicious Persons with 26 incidents",
         "Call For Service with 15 incidents",
         "Suspicious Activity with 11 incidents",
         "Pre-existing Knowledge with 5 incidents",
         "Special Investigation with 3 incidents",
         "Juvenile Contact with 2 incidents",
         "Suspicious Vehicles with 2 incidents",
         "Equipment Violation with 1 incidents"])

    end

    it "Display all of the reasons and their frequencies that are related with 'females' in the 'sex' category" do
      expect(Incident.sort_reasons_by_gender("Female")).to eq(
        ["Moving Violation with 18 incidents",
         "Special Investigation with 5 incidents",
         "Truancy/curfew with 4 incidents",
         "Suspicious Persons with 2 incidents",
         "Call For Service with 2 incidents",
         "Suspicious Vehicles with 1 incidents",
         "Special Detail Checkpoint with 1 incidents"])
    end

    #<------------------------OPTION 6 TESTS------------------------>

    it "Displays all of the locations and the frequency of incidents at each location" do
      expect(Incident.sort_reasons_by_location).to eq (
        ["District 7D has 56 incidents",
         "District 3D has 24 incidents",
         "District 6D has 16 incidents",
         "District 1D has 13 incidents",
         "13 incidents occured at an 'Unknown' location",
         "District 5D has 3 incidents",
         "District 2D has 2 incidents",
         "District 4D has 1 incidents"])
    end

    it "Displays all of the incidents for a spcific location e.g.(District: '1D')" do
      location1 = Location.find_by(district: "1D")
      expect(location1.parsed_get_all_reasons).to eq(
        ["1. Suspicious Persons with 5 incidents",
         "2. Moving Violation with 4 incidents",
         "3. Call For Service with 2 incidents",
         "4. Equipment Violation with 1 incidents",
         "5. Pre-existing Knowledge with 1 incidents"]
      )
    end
end
