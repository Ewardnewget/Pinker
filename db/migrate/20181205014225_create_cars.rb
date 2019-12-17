class CreateCars < ActiveRecord::Migration[5.1]
  def change
    create_table :cars do |t|
      t.string :number
      t.integer :person_number
      t.string :picture
      t.integer :driver_id
      

      t.timestamps
    end
  end
end
