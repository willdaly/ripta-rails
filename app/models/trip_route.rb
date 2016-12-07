class TripRoute < ActiveRecord::Base
  belongs_to :trip
  belongs_to :route
end
