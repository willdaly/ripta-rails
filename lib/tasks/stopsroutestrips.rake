
desc "create all stops routes and trips"
task :stopsroutestrips => :environment do

  JSON.parse(File.read('lib/data/stop_routes.json')).each do |stop|
    s = Stop.find_or_create_by(id: stop["stop_id"])
    routes = create_routes(stop["route_ids"])
    create_stop_routes(s.id, routes)
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

def create_stop_routes stop_id, route_ids_array
  route_ids_array.each do |route_id|
    StopRoute.find_or_create_by(stop_id: stop_id, route_id: route_id)
  end
end
