require 'rails_helper'

RSpec.describe Job, type: :model do
  it 'gets and sets customer_id, tradie_id, location, description,' do
      Job.destroy_all
      job=Job.new
      job.customer_id=1
      job.tradie_id=2
      location="Quba street"
      description="Dishwasher"
      job.save
      job=Job.first
      expect(job.customer_id).to eq(1)
      expect(job.tradie_id).to eq(2)
      expect(job.location).to eq("Quba street")
      expect(job.description).to eq("Dishwasher")
  end

      # t.integer :customer_id, null: false
      # t.integer :tradie_id
      # # t.integer :rating
      # # t.decimal :price, null: false
      # t.string :location, null: false
      # # t.string :type
      # # t.string :title, null: false
      # t.text :description
      # t.string :photo_url
      # # t.datetime :paid_at
end
