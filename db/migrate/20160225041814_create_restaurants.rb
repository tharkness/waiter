class CreateRestaurants < ActiveRecord::Migration
  def change
    create_table :restaurants do |t|
      t.string :name
      t.string :address
      t.integer :two_seat_wait, default: 0
      t.integer :four_seat_wait, default: 0
      t.integer :large_table_wait, default: 0
      t.boolean :waitlist
    end
  end
end
