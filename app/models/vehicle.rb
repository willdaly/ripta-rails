class Vehicle < ActiveRecord::Base
  belongs_to :trip
  belongs_to :route
  belongs_to :stop
end
