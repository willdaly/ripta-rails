class Trip < ActiveRecord::Base
  belongs_to :route
  has_many :stops, through: :route
  # has_many :route_stops, through: :route
  # has_many :stops, through: :route_stops
end
