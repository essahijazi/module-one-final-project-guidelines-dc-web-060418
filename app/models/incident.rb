class Incident < ActiveRecord::Base
  belongs_to :reason
  belongs_to :location

end
