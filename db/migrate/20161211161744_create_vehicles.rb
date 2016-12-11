class CreateVehicles < ActiveRecord::Migration
  def change
    create_table :vehicles do |t|
      t.references :trip, index: true, foreign_key: true
      t.references :route, index: true, foreign_key: true
      t.references :stop, index: true, foreign_key: true
    end
  end
end
