class CreateTenders < ActiveRecord::Migration
  def change
    create_table :tenders do |t|
      t.belongs_to :user
      t.belongs_to :job

      t.boolean :accepted, null: false, default: false
      t.integer :rating
      t.text :comment

      t.timestamps null: false
    end
  end
end
