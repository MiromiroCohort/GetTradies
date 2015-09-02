class CreateJobs < ActiveRecord::Migration
  def change
    create_table :jobs do |t|
      t.belongs_to :user

      t.decimal :price
      t.string :location, null: false
      t.string :job_type
      t.string :title
      t.text :description
      t.string :photo_url
      t.datetime :paid_at
      t.boolean :completed, null: false, default: false

      t.timestamps null: false
    end
  end
end
