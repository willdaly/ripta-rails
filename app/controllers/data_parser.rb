require 'json'
require 'open-uri'
require 'numbers_controller.rb'
# require 'gtfs-realtime'

# GTFS::Realtime.configure do |config|
#   # config.static_feed = "http://www.ripta.com/googledata/current/google_transit.zip"
#   # config.trip_updates_feed = "http://realtime.ripta.com:81/api/tripupdates"
#   config.vehicle_positions_feed = "http://realtime.ripta.com:81/api/vehiclepositions"
#   # config.service_alerts_feed = "http://realtime.ripta.com:81/api/servicealerts"
#   config.database_url = ENV["DATABASE_URL"]
# end

class DataParser
  STOP_ROUTES = 'app/assets/data/stop_routes.json'
  TRIPS = 'app/assets/data/trips.json'
  ROUTE_STOPS = 'app/assets/data/route_stops.json'
  VEHICLE_POSITIONS = 'http://realtime.ripta.com:81/api/vehiclepositions?format=json'

  # def self.config
  # end

  # DataParser.config.stop_routes...
  def initialize(user_stop_id)
    @user_stop_id = user_stop_id
  end

# 1. user's stop_id -> route_id
  def getRouteId
    @user_route_ids = []
    stop_routes_array = JSON.parse(File.read(STOP_ROUTES))
    for stop in stop_routes_array
      if stop["stop_id"] == @user_stop_id
        @user_route_ids = stop["route_ids"]
      end
    end

    for route in @user_route_ids
      @one_user_route = route
      puts "user route is #{@one_user_route}"
      getAllTripIds(route)
    end
  end

# 2. route_id -> trip_ids
  def getAllTripIds(route_id)
    trips_array = JSON.parse(File.read(TRIPS))
    all_trip_ids = []
    for trip in trips_array
      if trip["route_id"] == route_id
        all_trip_ids << trip["trip_id"]
      end
    end
    puts "all_trip_ids is #{all_trip_ids}"
    getCurrentTrips(all_trip_ids)
  end

# 3. trip_ids -> current trip_ids & stop_ids
  def getCurrentTrips(all_trip_ids)
    # current_trips = []
    current_stops = []

    # GTFS::Realtime.refresh_realtime_feed!
    vehicle_data = JSON.load(open(VEHICLE_POSITIONS))
    if vehicle_data == nil
      puts "can't open vehicle positions"
    else
      @entities_array = vehicle_data["entity"]
      puts "data objects: #{@entities_array[0, 4]}"
    end

    for trip_id in all_trip_ids
      for entity in @entities_array

        if entity["vehicle"] == nil
          puts "entity-vehicle fails"
        else
          if entity["vehicle"]["trip"] == nil
            puts "entity-vehicle-trip fails"
          else
            if entity["vehicle"]["trip"]["trip_id"] == nil
              puts "entity-vehicle-trip-trip-id fails"
            else
              if trip_id == entity["vehicle"]["trip"]["trip_id"]
                current_stops << entity["vehicle"]["trip"]["stop_id"]
                puts "adding #{entity["vehicle"]["trip"]["stop_id"]}"
              end
            end
          end
        end
        # if entity["vehicle"]["trip"]["trip_id"] == trip_id
        #   # current_trips << entity["vehicle"]["trip"]["trip_id"]
        #   current_stops << entity["vehicle"]["trip"]["stop_id"]
        #   puts "current stop is #{entity["vehicle"]["trip"]["stop_id"]}"
        # else
        #   puts "nothing to see here"
        # end
      end

    end

    getArrayIndexes(current_stops)
  end

# 5. route_id & stop_ids
  def getArrayIndexes(current_stops)
    route_stops_array = JSON.parse(File.read(ROUTE_STOPS))
    stop_index_array = []
    user_stop_index = 0

    for route in route_stops_array
      if route["route_id"] == @one_user_route
        for current_stop in current_stops
          user_stop_index = route["stop_ids"].index(@user_stop_id)

          stop_index_array << route["stop_ids"].index(current_stop)
          puts "index is #{route["stop_ids"].index(current_stop)}"
        end
      end
    end

    if stop_index_array.count == 0
      puts "there are no more buses running"
    else
      calculate(user_stop_index, stop_index_array)
    end

  end

# 6. computation
  def calculate(user_stop_index, stop_index_array)
    stops_away = stop_index_array[0]

    for index in stop_index_array
      if index < user_stop_index && index > stop_index_array[0]
        stops_away = index
      end
    end

    puts "bus is #{stops_away} stops away"
  end

end
