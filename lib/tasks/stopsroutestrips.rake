
desc "create all stops routes and trips"
task :stopsroutestrips => :environment do

  JSON.parse(File.read('lib/data/route_stops.json')).each do |obj|
    stop = Stop.find_or_create_by(id: obj["stop_id"])
    routes = create_routes(obj["route_ids"])
    create_route_stop(routes, stop.id)
  end

  JSON.parse(File.read('lib/data/trips.json')).each do |trip|
    Trip.find_or_create_by({id: trip["trip_id"], route_id: trip["route_id"], trip_headsign: trip["trip_headsign"], direction_id: trip["direction_id"]} )
  end

end

def create_routes route_ids
  route_ids.each do |route_id|
    route = Route.find_or_create_by(id: route_id)
  end
end

def create_route_stops route_ids_array, stop_id
  route_ids_array.each do |route_id|
    RouteStop.find_or_create_by(route_id: route_id, stop_id: stop_id)
  end
end
