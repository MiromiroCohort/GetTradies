class AddJobsTable < ActiveRecord::Migration
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

    create_table :jobs do |t|

    t.belongs_to :user

      # t.integer :customer_id, null: false
      t.decimal :price
      t.string :location, null:false
      t.string :job_type
      t.string :title
      t.text :description
      t.string :photo_url
      t.datetime :paid_at
      t.boolean :completed, null: false, default: false

      t.timestamps null: false
    end

    create_table :tenders do |t|

      t.belongs_to :user
      t.belongs_to :job

      # t.integer :job_id, null: false
      # t.integer :tradie_id, null: false
      t.boolean :accepted, null: false, default: false
      t.integer :rating
      t.text :comment

      t.timestamps null: false
    end

  end
end
