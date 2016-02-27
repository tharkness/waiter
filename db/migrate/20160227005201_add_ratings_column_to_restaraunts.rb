class AddRatingsColumnToRestaraunts < ActiveRecord::Migration
  def change
    add_column :restaraunts, :ratings, :string
  end
end
