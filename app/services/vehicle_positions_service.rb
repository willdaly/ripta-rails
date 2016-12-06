class VehiclePositionsService

  def initializer
  end

  def entities
    response["entity"]
  end

  private

  def response
    # confusing it seems not to work in initializer, response class variable returns nil
    url = HTTParty.get("http://realtime.ripta.com:81/api/vehiclepositions?format=json")
    JSON.parse(url.body)
  end
  
end
