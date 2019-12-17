class CreateSearches < ActiveRecord::Migration[5.1]
  def change
    create_table :searches do |t|
      t.datetime :time
      t.string :destination

      t.timestamps
    end
  end
end
