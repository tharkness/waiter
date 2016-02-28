class AddLatAndLonColumnToRestaraunts < ActiveRecord::Migration
  def change
    add_column :restaraunts, :lat, :string
    add_column :restaraunts, :lon, :string
  end
end
