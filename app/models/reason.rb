class Reason < ActiveRecord::Base
  has_many :incidents
  has_many :locations, through: :incidents

end
