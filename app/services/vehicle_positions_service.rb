class VehiclePositionsService
  attr_reader :response
  
  def initialize
    url = HTTParty.get("http://realtime.ripta.com:81/api/vehiclepositions?format=json")
    @response = JSON.parse(url.body)
  end

  def trip_ids
    entities.map{|entity| trip_id(entity) }
  end

  private

  def entities
    response["entity"]
  end

  def trip_id entity
    entity["vehicle"]["trip"]["trip_id"].to_i
  end

end
