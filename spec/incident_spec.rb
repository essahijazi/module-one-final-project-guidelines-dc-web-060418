require_relative '../config/environment.rb'

require_relative '../app/models/incident.rb'
require_relative '../app/models/reason.rb'
require_relative '../app/models/location.rb'
require 'bundler'

describe Incident do
    let(:incident) {Incident.first}

    it "knows average age for all incidents" do 
        expect(Incident.average_age).to eq("Average age for persons of stop and frisk incidents is: 35")
    end

    it "has method #most_common_hour that returns most common hour for stop and frisks" do 
        expect(Incident.most_common_hour).to be 11
    end

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
end