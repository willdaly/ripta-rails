class Route < ActiveRecord::Base
  has_many :stop_routes, :dependent => :destroy
  has_many :stops, :through => :stop_routes
  has_many :trips
end
