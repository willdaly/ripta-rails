class CreateTripRoutes < ActiveRecord::Migration
  def change
    create_table :trip_routes, :id => false do |t|
      t.references :trip, index: true
      t.references :route, index: true
    end
  end
end
