class AddImageColumnToJobs < ActiveRecord::Migration
  def self.up
      add_attachment :jobs,:image
  end

  def self.down
    remove_attachment :jobs, :image
  end
end
