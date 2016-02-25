class CreateHostesses < ActiveRecord::Migration
  def change
    create_table :hostesses do |t|
      t.references :restaraunt
      t.string :username
      t.string :password
    end
  end
end
