class CreateStudentOrders < ActiveRecord::Migration[5.1]
  def change
    create_table :student_orders do |t|
      t.belongs_to :student
      t.belongs_to :order
      t.float :bond
      t.boolean :is_creator

      t.timestamps
    end
  end
end
