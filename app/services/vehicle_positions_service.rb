class VehiclePositionsService
  attr_reader :response

  def initialize trip_ids
    url = HTTParty.get("http://realtime.ripta.com:81/api/vehiclepositions?format=json")
    entity = JSON.parse(url.body)["entity"]
    @response = entity.select{|obj| trip_ids.include?(trip_id(obj))}
  end

  def new_vehicles
    @response.map{|obj| new_vehicle(obj) }
  end

  private

  def trip_id entity
    entity["vehicle"]["trip"]["trip_id"].to_i
  end

  def new_vehicle obj
    vehicle = obj["vehicle"]
    trip = vehicle["trip"]
    Vehicle.new(id: vehicle["vehicle"]["id"], trip_id: trip["trip_id"], stop_id: vehicle["stop_id"], route_id: trip["route_id"])
  end

end
