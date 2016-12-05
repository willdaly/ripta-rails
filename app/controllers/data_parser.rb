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
  STOP_ROUTES = 'lib/data/stop_routes.json'
  TRIPS = 'lib/data/trips.json'
  ROUTE_STOPS = 'lib/data/route_stops.json'
  TRIP_STOPS = 'lib/data/stop_times_redux.json'
  VEHICLE_POSITIONS = 'http://realtime.ripta.com:81/api/vehiclepositions?format=json'

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
      return getAllTripIds(route)
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
    puts "all_trip_ids is #{all_trip_ids[0, 10]}"
    return getCurrentTrips(all_trip_ids)
  end

# 3. trip_ids -> current trip_ids & stop_ids
  def getCurrentTrips(all_trip_ids)
    current_trips = []
    # current_stops = []

    # GTFS::Realtime.refresh_realtime_feed!
    vehicle_data = JSON.load(open(VEHICLE_POSITIONS))
    if vehicle_data == nil
      puts "can't open vehicle positions"
    else
      @entities_array = vehicle_data["entity"]
      puts "data objects: #{@entities_array[0, 3]}"
    end

      for trip_id in all_trip_ids
        for entity in @entities_array
          if entity["vehicle"]["trip"]["trip_id"].to_i == trip_id
            trip_hash = {entity["vehicle"]["trip"]["trip_id"]=> entity["vehicle"]["stop_id"].to_i}
            current_trips << trip_hash
            puts "current trips are #{current_trips}"
          end
        end
      end

    return getArrayIndexes(current_trips)
  end

# 5. route_id & stop_ids
  def getArrayIndexes(current_trips)
    stop_index_array = []
    user_stop_index = 0
    trip_stops_array = JSON.parse(File.read(TRIP_STOPS))

    for trip in trip_stops_array
      for current_trip in current_trips
        # puts "current_trip: #{current_trip} / trip[0]: #{trip[0]}"
        if current_trip[trip[0]] != nil
          puts "current_trip[trip[0]] is #{current_trip[trip[0]]}"
          stops_array = trip[1]
          if stops_array.include?(@user_stop_id)
            puts "#{trip} comes to user"
            user_stop_index = stops_array.index(@user_stop_id)
            for stop in stops_array
              if stop == current_trip[trip[0]]
                stop_index_array << stops_array.index(current_trip[trip[0]])
              end
            end
          end
        end
      end
    end

    if stop_index_array.count == 0
      puts "there are no buses at this time"
    else
      return calculate(user_stop_index, stop_index_array)
    end

  end

# 6. computation
  def calculate(user_stop_index, stop_index_array)
    puts "user_stop_index is #{user_stop_index}"
    puts "stop_index_array is #{stop_index_array[0]}"
    for index in stop_index_array
      puts "in 1st index loop"
      if index > user_stop_index
        stop_index_array.delete(index)
      elsif index == user_stop_index
        puts "bus just passed"
      end
    end

    stops_away = user_stop_index.to_i - stop_index_array[0].to_i

    for index in stop_index_array
      puts "in 2nd index loop"
      if (user_stop_index - index) < stops_away
        stops_away = user_stop_index - index
      end
    end

    response = "bus is #{stops_away} stops away"
    return response
  end

end
