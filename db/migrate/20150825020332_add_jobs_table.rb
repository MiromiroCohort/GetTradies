class AddJobsTable < ActiveRecord::Migration
  def change
    create_table :jobs do |t|

      t.integer :customer_id, null: false
      t.integer :tradie_id
      t.integer :rating
      t.decimal :price
      t.string :location, null:false
      t.string :type
      t.string :title
      t.text :description
      t.string :photo_url
      t.datetime :paid_at

      t.timestamps null: false
    end
  end
end
