require 'require_all'
require_relative '../config/environment.rb'
require_all 'app'


location1 = Location.find_or_create_by(district: "1D")
location2 = Location.find_or_create_by(district: "2D")
location3 = Location.find_or_create_by(district: "3D")
location4 = Location.find_or_create_by(district: "4D")
location5 = Location.find_or_create_by(district: "5D")
location6 = Location.find_or_create_by(district: "6D")
location7 = Location.find_or_create_by(district: "7D")


reason1 = Reason.find_or_create_by(description: "Moving Violation")
reason2 = Reason.find_or_create_by(description: "Suspicious Activity")
reason3 = Reason.find_or_create_by(description: "Preexisting Knowledge")
reason4 = Reason.find_or_create_by(description: "Call for Service")
reason5 = Reason.find_or_create_by(description: "Equipment Violation")
reason6 = Reason.find_or_create_by(description: "Suspicious Persons")
reason7 = Reason.find_or_create_by(description: "Truancy/Curfew")
reason8 = Reason.find_or_create_by(description: "Juvenile Contact")
reason9 = Reason.find_or_create_by(description: "Special Detail Checkpoint")
reason10 = Reason.find_or_create_by(description: "Special Investigation")
reason11 = Reason.find_or_create_by(description: "Suspicious Vehicle")


incident1 = Incident.find_or_create_by(location: location1, reason: reason1, age: 20, sex: "Male", ethnicity: "White", race: "Not hispanic or latino", date: "2013-01-02 20:31:15")
incident2 = Incident.find_or_create_by(location: location3, reason: reason10, age: 34, sex: "Male", ethnicity: "Black", race: "Not hispanic or latino", date: "2013-01-02 20:31:15")
incident3 = Incident.find_or_create_by(location: location5, reason: reason11, age: 57, sex: "Femal", ethnicity: "Asian", race: "Not hispanic or latino", date: "2013-01-02 20:31:15")
incident4 = Incident.find_or_create_by(location: location2, reason: reason8, age: 72, sex: "Male", ethnicity: "Asian", race: "Not hispanic or latino", date: "2013-01-02 20:31:15")
incident5 = Incident.find_or_create_by(location: location4, reason: reason3, age: 43, sex: "Female", ethnicity: "Black", race: "Not hispanic or latino", date: "2013-01-02 20:31:15")
incident6 = Incident.find_or_create_by(location: location6, reason: reason10, age: 19, sex: "Female", ethnicity: "Black", race: "Not hispanic or latino", date: "2013-01-02 20:31:15")
incident7 = Incident.find_or_create_by(location: location1, reason: reason2, age: 56, sex: "Male", ethnicity: "White", race: "Not hispanic or latino", date: "2013-01-02 20:31:15")
incident8 = Incident.find_or_create_by(location: location4, reason: reason11, age: 64, sex: "Female", ethnicity: "Asian", race: "Not hispanic or latino", date: "2013-01-02 20:31:15")
