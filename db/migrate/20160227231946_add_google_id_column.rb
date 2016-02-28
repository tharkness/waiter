class AddGoogleIdColumn < ActiveRecord::Migration
  def change
    add_column :restaraunts, :google_id, :string
  end
end
