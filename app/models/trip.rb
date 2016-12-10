class Trip < ActiveRecord::Base
  belongs_to :route
  has_many :route_stops, through: :route
  has_many :stops, -> { includes(:route_stops).order('route_stops.index asc')}, through: :route_stops
end
