class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|

      t.string :username
      t.string :given_name
      t.string :family_name
      t.string :email, null: false
      t.string :profession, default: 'customer', null: false
      t.string :address
      t.text :description
      t.decimal :rates
      t.string :phone_number
      t.string :password_hash, null: false

      t.timestamps null: false
    end
  end
end
