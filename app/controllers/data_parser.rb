require 'json'
require 'open-uri'
require 'numbers_controller.rb'
# require 'gtfs-realtime'

STOP_ROUTES = '../data/stop_routes.json'
TRIPS = '../data/trips.json'
ROUTE_STOPS = '../data/route_stops.json'
VEHICLE_POSITIONS = 'http://realtime.ripta.com:81/api/vehiclepositions?format=json'

# GTFS::Realtime.configure do |config|
#   # config.static_feed = "http://www.ripta.com/googledata/current/google_transit.zip"
#   # config.trip_updates_feed = "http://realtime.ripta.com:81/api/tripupdates"
#   config.vehicle_positions_feed = "http://realtime.ripta.com:81/api/vehiclepositions"
#   # config.service_alerts_feed = "http://realtime.ripta.com:81/api/servicealerts"
#   config.database_url = ENV["DATABASE_URL"]
# end

class DataParser
  def initialize(user_stop_id)
    @user_stop_id = user_stop_id
  end

# 1. user's stop_id -> route_id
  def getRouteId(user_stop_id)
    @user_route_ids = []
    if user_stop_id == nil
      puts "wat"
    else
      @stop_routes_array = JSON.parse(File.read(STOP_ROUTES))
      for stop in @stop_routes_array
        if stop["stop_id"] == user_stop_id
          @user_route_ids = item["route_ids"]
        end
      end

      unless route_ids == nil
        getTripIds(route_ids)
      end
    end
  end

# 2. route_id -> trip_ids
  def getAllTripIds(route_id)
    @trips_array = JSON.parse(File.read(TRIPS))
    all_trip_ids = []
    for trip in @trips_array
      if trip[:route_id] = route_id
        all_trip_ids << trip[:trip_id]
      end
    end
    all_trip_ids
  end

# 3. trip_ids -> current trip_ids & stop_ids
  def getCurrentTrips(all_trip_ids)
    # current_trips = []
    current_stops = []

    # GTFS::Realtime.refresh_realtime_feed!
    vehicle_data = JSON.load(open(VEHICLE_POSITIONS))
    @entities_array = vehicle_data["entity"]

    for entity in @entities_array
      for trip_id in all_trip_ids
        if entity["vehicle"]["trip"]["trip_id"] == trip_id
          # current_trips << entity["vehicle"]["trip"]["trip_id"]
          current_stops << entity["vehicle"]["stop_id"]
        end
      end
    end

    getArrayIndexes(current_stops)
  end

# 4. route_id & stop_ids
  def getArrayIndexes(current_stops)
    route_stops_array = JSON.parse(File.read(ROUTE_STOPS))


  end

# 6. computation
  def calculate(user_stop_id, current_stops)
    stops_away = 0
    # some code here
    stops_away
  end
end
