require 'rails_helper'

def create_tenders
  user1 = User.new
  user1.email = "gin1@gmail.com"
  user1.password ='qwerty'
  user1.profession ='tradie'
  user1.save
  user = User.new
  user.email = "gin2@gmail.com"
  user.password = 'qwerty'
  user.profession = 'tradie'
  user.save
  user1.jobs.create location:"Quba street", description:"Dishwasher"
  job = user.jobs.create location:"Churchill Drive", description:"Oven"
  job.tenders.create user:user1
end

def delete_db_enteries
  User.destroy_all
  Job.destroy_all
  Tender.destroy_all
end