class Route < ActiveRecord::Base
  has_many :route_stops, :dependent => :destroy
  has_many :stops, :through => :route_stops
  has_many :trip_routes, :dependent => :destroy
  has_many :trips, :through => :trip_routes
end
