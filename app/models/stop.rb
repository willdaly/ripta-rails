class Stop < ActiveRecord::Base
  has_many :route_stops, :dependent => :destroy
  has_many :routes, :through => :route_stops
  has_many :trips, :through => :routes

  def trip_ids
    trips.pluck(:id)
  end
    
end
