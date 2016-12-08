class AddOrderToRouteStops < ActiveRecord::Migration
  def change
    add_column :route_stops, :order, :integer
  end
end
