class VehiclePositionsService

  def initializer
  end

  def trip_ids
    entities.map{|entity| trip_id(entity) }
  end

  private

  def response
    # confusing it seems not to work in initializer, response class variable returns nil
    url = HTTParty.get("http://realtime.ripta.com:81/api/vehiclepositions?format=json")
    JSON.parse(url.body)
  end

  def entities
    response["entity"]
  end

  def trip_id entity
    entity["vehicle"]["trip"]["trip_id"].to_i
  end

end
