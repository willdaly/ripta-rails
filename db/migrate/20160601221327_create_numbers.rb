class CreateNumbers < ActiveRecord::Migration
  def change
    create_table :numbers do |t|
      t.string :tocall
      t.timestamps null: false
    end
  end
end
