class VehiclePositionsService
  attr_reader :response

  def initialize
    url = HTTParty.get("http://realtime.ripta.com:81/api/vehiclepositions?format=json")
    @response = JSON.parse(url.body)
  end

  def new_vehicles
    entities.map{|entity| new_vehicle(entity) }
  end

  private

  def entities
    response["entity"]
  end

  def trip_id entity
    entity["vehicle"]["trip"]["trip_id"].to_i
  end

  def new_vehicle entity
    vehicle = entity["vehicle"]
    trip = vehicle["trip"]
    Vehicle.new(id: trip["vehicle"]["id"], trip_id: trip["trip_id"], stop_id: vehicle["stop_id"], route_id: trip["route_id"])
  end

end
