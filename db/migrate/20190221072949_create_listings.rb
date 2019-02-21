class CreateListings < ActiveRecord::Migration[5.2]
  def change
    create_table :listings do |t|
      t.belongs_to :user
      t.string :location_name
      t.string :address
      t.string :email
      t.integer :phone_number
      t.integer :ratings

      t.timestamps
    end
  end
end
