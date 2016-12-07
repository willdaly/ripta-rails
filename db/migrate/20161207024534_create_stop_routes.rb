class CreateStopRoutes < ActiveRecord::Migration
  def change
    create_table :stop_routes, :id => false do |t|
      t.references :stop, index: true
      t.references :route, index: true
    end
  end
end
