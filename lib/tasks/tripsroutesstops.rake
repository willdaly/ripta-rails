
desc "create all trips routes and stops"
task :tripsroutesstops => :environment do

  trips = parse_json('trips')

  trips.each do |obj|
    trip = create_trip(obj)
    route = create_route(trip.route_id)
    route_stop = find_route_stop(route.id)
    create_route_stops(route_stop)
    create_stops(route_stop["stop_ids"])
  end

end

def parse_json file_name
  JSON.parse(File.read('lib/data/' + file_name + '.json'))
end

def create_trip obj
  Trip.find_or_create_by({id: obj["trip_id"], route_id: obj["route_id"], trip_headsign: obj["trip_headsign"], direction_id: obj["direction_id"]} )
end

def create_route route_id
  Route.find_or_create_by(id: route_id)
end

@route_stops = parse_json('route_stops_tbarrman')

def find_route_stop route_id
  @route_stops.select {|obj| obj["route_id"] == route_id }.first
end

def create_route_stops route_stop
  route_stop["stop_ids"].each_with_index {|stop_id, index|
    RouteStop.find_or_create_by(
      route_id: route_stop["route_id"], stop_id: stop_id, order: index
    )}
end

def create_stops stop_ids
  stop_ids.each do |id|
    Stop.find_or_create_by(id: id)
  end
end
