require 'json'
require 'numbers_controller.rb'

STOP_ROUTES = '../data/stop_routes.json'
TRIPS = '../data/trips.json'
ROUTE_STOPS = '../data/route_stops.json'
RIPTAAPI = 'http://realtime.ripta.com:81/api/vehiclepositions?format=json'

class DataParser
  def initialize(user_stop_id)
    @user_stop_id = user_stop_id
  end

# 1. user's stop_id -> route_id
  def getRouteId(user_stop_id)
    if user_stop_id == nil
      puts "wat"
      break
    else
      @stop_routes_array = File.read(STOP_ROUTES)
      for stop in @stop_routes_array
        if stop["stop_id"] == user_stop_id
          route_ids = item["route_ids"]
        end
      end

      if route_ids == nil
        break
      else
        getTripIds(route_ids)
      end
    end
  end

# 2. route_id -> trip_ids
  def getAllTripIds(route_id)
    @trips_array = File.read(TRIPS)
    all_trip_ids = []
    for trip in @trips_array
      if trip[:route_id] = route_id
        all_trip_ids << trip[:trip_id]
      end
    end
    all_trip_ids
  end

# 3. trip_ids -> current trip_ids
  def getCurrentTrips(all_trip_id)
    current_trips = []
    # some code here
    getCurrentStops(current_trips)
  end

# 4. current trip_ids -> stop_ids
  def getCurrentStops(current_trips)
    current_stops = []
    # some code here
    current_stops
  end

# 5. route_id & stop_ids
  def getArrayIndexes(current_stops)
    @route_stops_array = FILE.read(ROUTE_STOPS)

  end

# 6. computation
  def calculate(user_stop_id, current_stops)
    stops_away = 0
    # some code here
    stops_away
  end
end
