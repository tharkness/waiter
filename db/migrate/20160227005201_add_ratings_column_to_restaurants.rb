class AddRatingsColumnToRestaurants < ActiveRecord::Migration
  def change
    add_column :restaurants, :ratings, :string
  end
end
