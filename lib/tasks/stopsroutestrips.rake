
desc "create all trips"
task :stopsroutestrips => :environment do

  JSON.parse(File.read('lib/data/stop_routes.json')).each do |stop|
    Stop.find_or_create_by(id: stop["stop_id"])
    create_routes(stop["route_ids"])
  end

  JSON.parse(File.read('lib/data/trips.json')).each do |trip|
    Trip.find_or_create_by({id: trip["trip_id"], route_id: trip["route_id"], trip_headsign: trip["trip_headsign"], direction_id: trip["direction_id"]} )
  end

end

def create_routes route_ids
  route_ids.each do |route_id|
    Route.find_or_create_by(id: route_id)
  end
end
