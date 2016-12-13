class Message < ActiveRecord::Base
  attr_reader :stop

  def initialize posted_text
    @posted_text = posted_text
    @stop = Stop.find_by_id(posted_text)
  end

  def text
    @stop ? success : error
  end

  private

  def error
    @posted_text + " is not a valid stop id"
  end

  def success
    vehicles = VehiclePositionsService.new(@stop.trip_ids).new_vehicles
    selected_vehicles = vehicles.select {|vehicle| vehicle.stops_away(@stop)}
    sorted_vehicles = selected_vehicles.sort_by do |vehicle|
      vehicle.stops_away(@stop)
    end
    strings = sorted_vehicles.map{|vehicle| vehicle.stops_away_string(@stop)}
    if strings.empty?
      "found no updates on buses stopping at #{@posted_text}"
    elsif strings.count == 1
      strings.first
    else
      strings[0..1].join(", ")
    end
  end

end
