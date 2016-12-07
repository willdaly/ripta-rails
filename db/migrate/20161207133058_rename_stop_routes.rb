class RenameStopRoutes < ActiveRecord::Migration
  def change
    rename_table(:stop_routes, :route_stops)
  end
end
