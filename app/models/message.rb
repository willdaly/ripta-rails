class Message < ActiveRecord::Base

  def text
    valid_stop_id ? "your bus is coming soon" : error
  end

  def current_trips
    all_trips_scheduled_to_stop_ever = valid_stop_id.trips
    all_trips_scheduled_to_stop_ever.select{|trip| Trip.all_current_ids.include?(trip.id)}
  end

  def hmm
    vehicles = VehiclePositionsService.new.vehicles
    vehicles_on_relevant_trip = vehicles.select{|vehicle| current_trips.include?(vehicle.trip)}

  end

  private

  def valid_stop_id
    Stop.find_by_id(self.posted_text)
  end

  def error
    self.posted_text + " is not a valid stop id"
  end
  #strewn about logic
  # def current_trips
  #   all_trips_scheduled_to_stop_ever = valid_stop_id.trips
  #   all_trips_scheduled_to_stop_ever.select{|trip| Trip.all_current_ids.include?(trip.id)}
  # end

  # Trip.find_by_id(2390116).stops.index(stop)

end
