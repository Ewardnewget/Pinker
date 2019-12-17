class CreateOrders < ActiveRecord::Migration[5.1]
  def change
    create_table :orders do |t|
      t.integer :number
      t.integer :cur_number
      t.datetime :time
      t.string :destination
      t.integer :driver_id
      t.boolean :driver_finished
      t.boolean :student_finished

      t.timestamps
    end
  end
end
