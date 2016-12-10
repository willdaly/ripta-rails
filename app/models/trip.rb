class Trip < ActiveRecord::Base
  belongs_to :route
  has_many :route_stops, through: :route
  has_many :stops, -> { includes(:route_stops).order('route_stops.order asc')}, through: :route_stops

  # def self.all_current_ids
  #   VehiclePositionsService.new.trip_ids
  # end

  def stop_index stop
    stops.index(stop)
  end

end
