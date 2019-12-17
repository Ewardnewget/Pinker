class CreateStudents < ActiveRecord::Migration[5.1]
  def change
    create_table :students do |t|
      t.string :name
      t.integer :sex
      t.string :phone
      t.string :id_card
      t.string :email
      t.string :head
      t.string :password_digest
      t.boolean :pass

      t.timestamps
    end
  end
end
