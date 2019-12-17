class CreateDrivers < ActiveRecord::Migration[5.1]
  def change
    create_table :drivers do |t|
      t.string :name
      t.integer :sex
      t.string :phone
      t.string :id_card
      t.string :license
      t.float :bond
      t.string :head
      t.string :email
      t.string :password_digest
      t.boolean :pass

      t.timestamps
    end
  end
end
