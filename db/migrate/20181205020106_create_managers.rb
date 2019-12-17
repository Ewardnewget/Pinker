class CreateManagers < ActiveRecord::Migration[5.1]
  def change
    create_table :managers do |t|
      t.string :name
      t.integer :sex
      t.string :phone
      t.string :email
      t.string :password_digest

      t.timestamps
    end
  end
end
