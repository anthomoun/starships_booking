class CreateStarships < ActiveRecord::Migration[7.0]
  def change
    create_table :starships do |t|
      t.string :name
      t.string :starship_type
      t.integer :number_of_persons
      t.float :latitude
      t.float :longitude
      t.string :address
      t.boolean :booked, default: false
      t.float :price
      t.text :description
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
