class Messages < ActiveRecord::Migration
  def change
    add_column :messages, :posted_text, :string
  end
end
