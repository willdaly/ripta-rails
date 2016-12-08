class CreateTrips < ActiveRecord::Migration
  def change
    create_table :trips do |t|
      t.references :route, index: true
      t.string :trip_headsign
      t.binary :direction_id

      t.timestamps null: false
    end
  end
end
