class AddProfilesTable < ActiveRecord::Migration
  def change
    create_table :profiles do |t|

      t.string :given_name
      t.string :family_name
      t.string :phone_number
      t.text :address
      t.integer :user_id

      t.timestamps null: false
    end
  end
end