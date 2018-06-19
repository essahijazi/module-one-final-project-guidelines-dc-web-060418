class Location < ActiveRecord::Base
  has_many :incidents
  has_many :reasons, through: :incidents




  
end
