require 'json'
STOP_ROUTES = '../data/stop_routes.json'
TRIPS = '../data/trips.json'
ROUTE_STOPS = '../data/route_stops.json'

file = File.read(STOP_ROUTES)
data_hash = JSON.parse(file)

class DataParser

  def getRouteId(user_stop_id)
    route_id = 0

    # some code here

    getTripIds(route_id)
  end

  def getAllTripIds(route_id)
    all_trip_ids = []

    # some code here

    all_trip_ids
  end

  def getCurrentTrips(all_trip_id)
    current_trips = []

    # some code here

    getCurrentStops(current_trips)
  end

  def getCurrentStops(current_trips)
    current_stops = []

    # some code here

    current_stops
  end

  def calculate(user_stop_id, current_stops)
    stops_away = 0

    # some code here

    stops_away
  end

end
